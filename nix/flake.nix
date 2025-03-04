{
  description = "nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    darwin.url = "github:LnL7/nix-darwin/master";
    mac-app-util.url = "github:hraban/mac-app-util";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, darwin, mac-app-util, home-manager }:
    let
      configuration = { pkgs, config, ... }: {
        environment.systemPackages = [
          # https://github.com/nix-community/home-manager/issues/1341
          pkgs.mkalias # Find packages installed by nix in spotlight
          pkgs.wezterm
          pkgs.neovim
          pkgs.brave
          pkgs.git
        ];

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 6;

        system.defaults = {
          dock.autohide = true;
          loginwindow.GuestEnabled = false;
          NSGlobalDomain.AppleICUForce24HourTime = true;
          NSGlobalDomain.AppleInterfaceStyle = "Dark";
          NSGlobalDomain.KeyRepeat = 0;
          NSGlobalDomain.InitialKeyRepeat = 15;
        };

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "aarch64-darwin";
        users.users.alexschoenwitz = {
          name = "alexschoenwitz";
          home = "/Users/alexschoenwitz";
        };

        home-manager.users.alexschoenwitz = {
          imports = [
            ./home.nix # Create this file for your home-manager configuration
          ];
          home.stateVersion = "24.11"; # or your desired version
        };
      };
    in {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#simple
      darwinConfigurations."simple" = darwin.lib.darwinSystem {
        modules = [
          configuration
          mac-app-util.darwinModules.default
          home-manager.darwinModules.home-manager
        ];
      };
    };
}
