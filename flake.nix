{
  description = "nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    mac-app-util.url = "github:hraban/mac-app-util";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      darwin,
      mac-app-util,
      home-manager,
      nix-homebrew,
      homebrew-core,
      homebrew-cask,
      homebrew-bundle,
    }:
    let
      username = "alexschoenwitz";
      system = "aarch64-darwin";
    in
    {
      darwinConfigurations = {
        macbook = darwin.lib.darwinSystem {
          inherit system;
          modules = [
            mac-app-util.darwinModules.default
            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                enable = true;
                user = username;
                taps = {
                  "homebrew/homebrew-core" = homebrew-core;
                  "homebrew/homebrew-cask" = homebrew-cask;
                  "homebrew/homebrew-bundle" = homebrew-bundle;
                };

              };
            }
            home-manager.darwinModules.home-manager
            {
              # System configuration
              nix.settings.experimental-features = [
                "nix-command"
                "flakes"
              ];

              # User configuration
              users.users.${username} = {
                name = username;
                home = "/Users/${username}";
              };

              system.configurationRevision = self.rev or self.dirtyRev or null;
              system.stateVersion = 6;

              # System defaults
              system.defaults = {
                dock.autohide = true;
                loginwindow.GuestEnabled = false;
                NSGlobalDomain = {
                  ApplePressAndHoldEnabled = false;
                  KeyRepeat = 2;
                  InitialKeyRepeat = 15;
                  AppleShowScrollBars = "Always";
                  NSWindowResizeTime = 0.1;
                  NSAutomaticCapitalizationEnabled = false;
                  NSAutomaticDashSubstitutionEnabled = false;
                  NSAutomaticPeriodSubstitutionEnabled = false;
                  NSAutomaticQuoteSubstitutionEnabled = false;
                  NSAutomaticSpellingCorrectionEnabled = false;
                  AppleInterfaceStyle = "Dark";
                  NSDocumentSaveNewDocumentsToCloud = false;
                  _HIHideMenuBar = false;
                  "com.apple.springing.delay" = 0.0;
                };
              };

              # System packages and settings
              nixpkgs = {
                hostPlatform = system;
                config.allowUnfree = true;
              };

              homebrew = {
                enable = true;
                onActivation = {
                  autoUpdate = true;
                  upgrade = true;
                  cleanup = "zap";
                };
                casks = [
                  "1password"
                  "ghostty"
                ];
              };

              # Home Manager configuration
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${username} = {
                  imports = [
                    ./modules/home.nix
                    ./modules/pkgs.nix
                    ./modules/git
                    ./modules/nvim
                    ./modules/ghostty
                  ];
                };
              };
            }
          ];
        };
      };
    };
}
