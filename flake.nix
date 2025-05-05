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

    mac-app-util = {
      url = "github:hraban/mac-app-util/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      darwin,
      home-manager,
      nixpkgs,
      nixvim,
      mac-app-util,
      ...
    }:
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.unix;

      nixpkgsFor = forAllSystems (
        system:
        import nixpkgs {
          inherit system;
        }
      );
    in
    {
      darwinConfigurations = {
        home = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./machines/home
            mac-app-util.darwinModules.default
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = false;
              home-manager.sharedModules = [
                nixvim.homeManagerModules.nixvim
                mac-app-util.homeManagerModules.default
              ];
              home-manager.users."alexandre.schoenwitz" = {
                imports = [
                  ./modules/ghostty
                  ./modules/git
                  ./modules/go.nix
                  ./modules/home.nix
                  ./modules/nixvim
                  ./modules/pkgs.nix
                  ./modules/tmux
                  ./modules/vscode
                  ./modules/zsh
                ];
              };
            }
          ];
        };
        work = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./machines/work
            mac-app-util.darwinModules.default
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = false;
              home-manager.sharedModules = [
                nixvim.homeManagerModules.nixvim
                mac-app-util.homeManagerModules.default
              ];
              home-manager.users."alexandre.schoenwitz" = {
                imports = [
                  ./modules/ghostty
                  ./modules/git
                  ./modules/go.nix
                  ./modules/home.nix
                  ./modules/nixvim
                  ./modules/pkgs.nix
                  ./modules/tmux
                  ./modules/vscode
                  ./modules/zsh
                ];
              };
            }
          ];
        };
      };

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
                  ./result/sw/bin/darwin-rebuild switch --flake . 
                fi
              '')
            ];
          };
        }
      );
    };
}
