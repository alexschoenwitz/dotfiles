{ pkgs, user, ... }:
{
  nixpkgs.config.allowUnfree = true;
  nix.package = pkgs.nix;
  nix.settings = {
    trusted-users = [
      "root"
      user.username
    ];
    experimental-features = [ "nix-command" "flakes" ];
  };

  nix.gc = {
    automatic = true;
    interval = { Weekday = 0; Hour = 3; Minute = 0; };
    options = "--delete-older-than 30d";
  };

  nix.optimise = {
    automatic = true;
    interval = { Weekday = 0; Hour = 4; Minute = 0; };
  };
  system.stateVersion = 5;

  security.pam.services.sudo_local.touchIdAuth = true;

  programs.fish.enable = true;
  users.users.${user.username} = {
    name = user.username;
    home = user.homeDirectory;
    shell = pkgs.bash;
  };

  homebrew = {
    enable = true;
    casks = [ "1password" ];
  };

  system = {
    primaryUser = user.username;
    defaults = {
      dock = {
        autohide = true;
        autohide-delay = 0.0;
        orientation = "bottom";
        tilesize = 42;
        showhidden = true;
        show-recents = false;
        show-process-indicators = true;
        expose-animation-duration = 0.1;
        expose-group-apps = true;
        launchanim = false;
        mineffect = "scale";
        mru-spaces = false;
        persistent-apps = [
          "/Applications/Brave Browser.app"
          "/Applications/Ghostty.app"
        ];
      };
      NSGlobalDomain = {
        ApplePressAndHoldEnabled = false;
        KeyRepeat = 1;
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
      finder = {
        FXPreferredViewStyle = "Nlsv";
        _FXShowPosixPathInTitle = true;
        FXEnableExtensionChangeWarning = false;
        AppleShowAllFiles = true;
        ShowStatusBar = true;
        ShowPathbar = true;
      };
      CustomUserPreferences = {
        "com.apple.NetworkBrowser" = {
          BrowseAllInterfaces = true;
        };
        "com.apple.screensaver" = {
          askForPassword = true;
          askForPasswordDelay = 0;
        };
        "com.apple.trackpad" = {
          scaling = 2;
        };
        "com.apple.mouse" = {
          scaling = 2.5;
        };
        "com.apple.desktopservices" = {
          DSDontWriteNetworkStores = false;
        };
        "com.apple.LaunchServices" = {
          LSQuarantine = true;
        };
        "com.apple.finder" = {
          ShowExternalHardDrivesOnDesktop = false;
          ShowRemovableMediaOnDesktop = false;
          WarnOnEmptyTrash = false;
        };
        "NSGlobalDomain" = {
          NSNavPanelExpandedStateForSaveMode = true;
          NSTableViewDefaultSizeMode = 1;
          WebKitDeveloperExtras = true;
        };
        "com.apple.ImageCapture" = {
          "disableHotPlug" = true;
        };
        "com.apple.dock" = {
          size-immutable = true;
        };
        "com.apple.symbolichotkeys" = {
          AppleSymbolicHotKeys = {
            "32" = {
              enabled = false;
            }; # Mission Control
            "33" = {
              enabled = false;
            }; # Show Desktop (F11)
            "34" = {
              enabled = false;
            }; # Application windows
            "35" = {
              enabled = false;
            }; # Mission Control - Move left a space (Ctrl+Left)
            "36" = {
              enabled = false;
            }; # Mission Control - Move right a space (Ctrl+Right)
            "37" = {
              enabled = false;
            }; # Mission Control - Switch to Desktop 1
            "79" = {
              enabled = false;
            }; # Mission Control - Move up (Ctrl+Up)
            "80" = {
              enabled = false;
            }; # Mission Control - Move down (Ctrl+Down)
            "81" = {
              enabled = false;
            }; # Application windows (Ctrl+Down)
          };
        };
      };
    };
  };
}
