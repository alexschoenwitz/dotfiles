{
  description = "alexschoenwitz nix-darwin system flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    llm-agents = {
      url = "github:numtide/llm-agents.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:Misterio77/nix-colors";

    nixos-lima = {
      url = "github:nixos-lima/nixos-lima";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      darwin,
      fenix,
      home-manager,
      llm-agents,
      nix-colors,
      nixos-lima,
      nixpkgs,
      nixvim,
      ...
    }:
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.unix;

      nixpkgsFor = forAllSystems (
        system:
        import nixpkgs {
          system = system;
        }
      );

      user = import ./lib/user.nix;

      dotnetBinaryOverlay = final: prev: {
        dotnetCorePackages = prev.dotnetCorePackages // {
          sdk_8_0 = prev.dotnetCorePackages.sdk_8_0-bin;
          runtime_8_0 = prev.dotnetCorePackages.runtime_8_0-bin;
        };
      };

      commonOverlays = [
        dotnetBinaryOverlay
        fenix.overlays.default
      ];

      homeManagerConfig =
        system: userOverride: {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = false;
          home-manager.sharedModules = [ nixvim.homeModules.nixvim ];
          home-manager.extraSpecialArgs = {
            user = userOverride;
            llm-agents-pkgs = llm-agents.packages.${system};
            inherit nix-colors;
          };
        };
    in
    {
      darwinConfigurations = {
        home = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = {
            user = user;
          };
          modules = [
            ./machines/home
            { nixpkgs.overlays = commonOverlays; }
            home-manager.darwinModules.home-manager
            (homeManagerConfig "aarch64-darwin" user)
          ];
        };
        work = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = {
            user = user;
          };
          modules = [
            ./machines/work
            { nixpkgs.overlays = commonOverlays; }
            home-manager.darwinModules.home-manager
            (homeManagerConfig "aarch64-darwin" user)
          ];
        };
      };

      nixosConfigurations = {
        vm = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          specialArgs = {
            user = user // {
              username = "lima";
            };
          };
          modules = [
            nixos-lima.nixosModules.lima
            ./machines/vm
            { nixpkgs.overlays = commonOverlays; }
            home-manager.nixosModules.home-manager
            (homeManagerConfig "aarch64-linux" (user // { username = "lima"; }))
          ];
        };
      };

      formatter = forAllSystems (system: nixpkgsFor.${system}.nixfmt);

      checks = forAllSystems (
        system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          format-check = pkgs.runCommand "format-check" { buildInputs = [ pkgs.nixfmt ]; } ''
            cd ${./.}
            nixfmt --check .
            touch $out
          '';
        }
      );

      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          default = pkgs.mkShellNoCC {
            buildInputs = with pkgs; [
              (writeScriptBin "dot-clean" ''
                sudo nix-env --delete-generations +5 --profile /nix/var/nix/profiles/system
                nix-collect-garbage -d --delete-older-than 30d
              '')
              (writeScriptBin "dot-sync" ''
                git pull --rebase origin main
                nix flake update
                dot-clean
                dot-apply
              '')
              (writeScriptBin "dot-apply" ''
                nix build "./#darwinConfigurations.$(hostname | cut -f1 -d'.').system"
                sudo ./result/sw/bin/darwin-rebuild switch --flake .
                if limactl list --json 2>/dev/null | ${pkgs.jq}/bin/jq -e 'select(.name=="nixos" and .status=="Running")' >/dev/null 2>&1; then
                  echo "Rebuilding NixOS VM..."
                  dot-vm-rebuild
                fi
              '')
              (writeScriptBin "dot-check" ''
                echo "Checking flake..."
                nix flake check
                echo ""
                echo "Validating configuration..."
                MACHINE=$(hostname | cut -f1 -d'.')
                if nix eval --json "./#darwinConfigurations.$MACHINE.config.system.stateVersion" 2>/dev/null; then
                  echo "✓ Configuration for '$MACHINE' is valid"
                else
                  echo "✗ Configuration for '$MACHINE' not found"
                  echo "Available configurations: home, work"
                  exit 1
                fi
              '')
              (writeScriptBin "dot-vm-start" ''
                STATUS=$(limactl list --json 2>/dev/null | ${pkgs.jq}/bin/jq -r 'select(.name=="nixos") | .status')
                if [ -z "$STATUS" ]; then
                  echo "Creating NixOS VM..."
                  limactl start --tty=false --name=nixos ./machines/vm/nixos.yaml
                  echo "Applying dotfiles configuration..."
                  dot-vm-rebuild
                elif [ "$STATUS" != "Running" ]; then
                  limactl start nixos
                else
                  echo "NixOS VM is already running."
                fi
              '')
              (writeScriptBin "dot-vm-shell" ''
                ssh -F /Users/${user.username}/.lima/nixos/ssh.config lima-nixos
              '')
              (writeScriptBin "dot-vm-rebuild" ''
                limactl shell nixos -- sudo nixos-rebuild switch --flake /Users/${user.username}/.config/dotfiles#vm
                ssh -F /Users/${user.username}/.lima/nixos/ssh.config -O exit lima-nixos 2>/dev/null || true
              '')
            ];
          };

          projects = pkgs.mkShell {
            DOTNET_ROOT = "${pkgs.dotnetCorePackages.sdk_10_0-bin}/share/dotnet";
            PROTOC_INCLUDE = "${pkgs.protobuf}/include";
            LOCALE_ARCHIVE = pkgs.lib.optionalString pkgs.stdenv.isLinux "${pkgs.glibcLocales}/lib/locale/locale-archive";
            shellHook = ''
              export SDKROOT=${pkgs.apple-sdk}/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk
              export CPATH="$SDKROOT/usr/include"
              export LIBRARY_PATH="$SDKROOT/usr/lib"

              mkdir -p .nix-bin
              cat > .nix-bin/xcrun <<'EOF'
              #!/bin/bash
              if [[ "$1" == "--show-sdk-path" ]]; then
                echo "${pkgs.apple-sdk}/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk"
              else
                echo "xcrun: unsupported command: $@" >&2
                exit 1
              fi
              EOF
              chmod +x .nix-bin/xcrun
              export PATH="$(pwd)/.nix-bin:$PATH"
            '';
            packages = with pkgs; [
              awscli2
              bashInteractive
              dotnetCorePackages.sdk_10_0-bin
              envsubst
              flutter
              just
              jwt-cli
              lcov
              openfga-cli
              protoc-gen-dart
              yq
              apple-sdk
            ];
          };
        }
      );
    };
}
