{ pkgs, ... }:
{
  nixpkgs.config = {
    allowUnfree = true;
  };
  nix.package = pkgs.nix;
  nix.settings.trusted-users = [
    "root"
    "alexandre.schoenwitz"
  ];
  # do not try to manage nix installation:
  nix.enable = false;
  system.stateVersion = 5;

  security.pam.services.sudo_local.touchIdAuth = true;

  programs.fish.enable = true;
  users.users."alexandre.schoenwitz" = {
    name = "alexandre.schoenwitz";
    home = "/Users/alexandre.schoenwitz";
    shell = pkgs.fish;
  };

  homebrew = {
    enable = true;
    casks = [
      "1password"
      "brave-browser"
      "visual-studio-code"
    ];
  };

  system = {
    primaryUser = "alexandre.schoenwitz";
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
      };
    };
  };
}
