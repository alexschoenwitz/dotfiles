{
  description = "alexschoenwitz nix-darwin system flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
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
      ...
    }:
    {
      darwinConfigurations = {
        alexschoenwitz = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./machines/home
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = false;
              home-manager.users.alexschoenwitz = {
                imports = [
                  ./modules/home.nix
                  ./modules/pkgs.nix
                  ./modules/git
                  ./modules/nvim
                  ./modules/ghostty
                ];
              };
            }
          ];
        };
      };
    };
}
