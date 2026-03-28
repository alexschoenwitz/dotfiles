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

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
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
      nix-index-database,
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

      dotnetBinaryOverlay = _final: prev: {
        dotnetCorePackages = prev.dotnetCorePackages // {
          sdk_8_0 = prev.dotnetCorePackages.sdk_8_0-bin;
          runtime_8_0 = prev.dotnetCorePackages.runtime_8_0-bin;
        };
      };

      commonOverlays = [
        dotnetBinaryOverlay
        fenix.overlays.default
      ];

      homeManagerConfig = system: userOverride: {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = false;
        home-manager.sharedModules = [
          nixvim.homeModules.nixvim
          nix-index-database.homeModules.default
        ];
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
              '')
              deadnix
              (writeScriptBin "dot-check" ''
                echo "Checking flake..."
                nix flake check
                echo ""
                echo "Checking for dead code..."
                deadnix --fail ${./.}
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
            ];
          };

        }
      );
    };
}
