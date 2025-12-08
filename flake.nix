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
  };

  outputs =
    {
      darwin,
      home-manager,
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
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = false;
              home-manager.sharedModules = [
                nixvim.homeModules.nixvim
              ];
              home-manager.extraSpecialArgs = {
                user = user;
              };
            }
          ];
        };
        work = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = {
            user = user;
          };
          modules = [
            ./machines/work
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = false;
              home-manager.sharedModules = [
                nixvim.homeModules.nixvim
              ];
              home-manager.extraSpecialArgs = {
                user = user;
              };
            }
          ];
        };
      };

      formatter = forAllSystems (system: nixpkgsFor.${system}.nixfmt-rfc-style);

      checks = forAllSystems (
        system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          format-check = pkgs.runCommand "format-check" { buildInputs = [ pkgs.nixfmt-rfc-style ]; } ''
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
                nix-collect-garbage -d --delete-older-than 30d
              '')
              (writeScriptBin "dot-sync" ''
                git pull --rebase origin main
                nix flake update
                dot-clean
                dot-apply
              '')
              (writeScriptBin "dot-apply" ''
                if test $(uname -s) == "Linux"; then
                  sudo nixos-rebuild switch --flake .#
                fi
                if test $(uname -s) == "Darwin"; then
                  nix build "./#darwinConfigurations.$(hostname | cut -f1 -d'.').system"
                  sudo ./result/sw/bin/darwin-rebuild switch --flake .
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
            ];
          };
        }
      );
    };
}
