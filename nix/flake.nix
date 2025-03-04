{
  description = "Simplified nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    mac-app-util.url = "github:hraban/mac-app-util";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, darwin, mac-app-util, home-manager }:
    let
      username = "alexschoenwitz";
      system = "aarch64-darwin";
    in {
      darwinConfigurations."macbook" = darwin.lib.darwinSystem {
        inherit system;
        modules = [
          mac-app-util.darwinModules.default
          home-manager.darwinModules.home-manager
          {
            # System configuration
            nix.settings.experimental-features = ["nix-command" "flakes"];
            system.configurationRevision = self.rev or self.dirtyRev or null;
            system.stateVersion = 6;
            
            # System defaults
            system.defaults = {
              dock.autohide = true;
              loginwindow.GuestEnabled = false;
              NSGlobalDomain = {
                AppleICUForce24HourTime = true;
                AppleInterfaceStyle = "Dark";
                KeyRepeat = 0;
                InitialKeyRepeat = 15;
              };
            };
            
            # System packages and settings
            nixpkgs.hostPlatform = system;
            environment.systemPackages = with nixpkgs.legacyPackages.${system}; [
              wezterm
              neovim
              brave
              git
            ];
            
            homebrew = {
              enable = true;
              onActivation.autoUpdate = true;
              onActivation.autoUpgrade = true;
              onActivation.cleanup = "zap"; 
              
              casks = [
                "1password"
              ];
            };
            
            # User configuration
            users.users.${username} = {
              name = username;
              home = "/Users/${username}";
            };
            
            # Home Manager configuration
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${username} = { pkgs, ... }: {
                home.stateVersion = "24.11";
                home.packages = with pkgs; [
                  zsh
                  bat
                  ripgrep
                  nil
                  nixfmt-classic
                  cargo
                  _1password-cli
                ];
                
                # Git config
                programs.git = {
                  enable = true;
                  userName = "Alexandre Schönwitz";
                  userEmail = "alexandre.schoenwitz@gmail.com";
                };
                
                # Zsh config with Gruvbox theme
                programs.zsh = {
                  enable = true;
                  enableCompletion = true;
                  autosuggestion.enable = true;
                  syntaxHighlighting.enable = true;
                  oh-my-zsh = {
                    enable = true;
                    plugins = [ "git" "sudo" ];
                  };
                  initExtra = let
                    gruvbox-zsh-theme = pkgs.fetchFromGitHub {
                      owner = "sbugzu";
                      repo = "gruvbox-zsh";
                      rev = "c54443c8d3da35037b7ae3ca73b30b45bc91a9e7";
                      sha256 = "sha256-pxG2PCw4hAgqu1T9DVjqdHM1t4g32B+N4URmAtoVdsU=";
                    };
                  in ''
                    source ${gruvbox-zsh-theme}/gruvbox.zsh-theme
                    SOLARIZED_THEME="dark"
                    GRUVBOX_DARK_PALETTE="dark"
                  '';
                };
                
                # Neovim with LazyVim & Gruvbox
                programs.neovim = {
                  enable = true;
                  defaultEditor = true;
                  viAlias = true;
                  vimAlias = true;
                };
                
                # Configuration files
                xdg.configFile = {
                  # Gruvbox theme for oh-my-zsh
                  "oh-my-zsh/custom/themes/gruvbox.zsh-theme".source = let
                    gruvbox-zsh-theme = pkgs.fetchFromGitHub {
                      owner = "sbugzu";
                      repo = "gruvbox-zsh";
                      rev = "c54443c8d3da35037b7ae3ca73b30b45bc91a9e7";
                      sha256 = "sha256-pxG2PCw4hAgqu1T9DVjqdHM1t4g32B+N4URmAtoVdsU=";
                    };
                  in "${gruvbox-zsh-theme}/gruvbox.zsh-theme";
                  
                  # WezTerm with Gruvbox
                  "wezterm/wezterm.lua".text = ''
                    local wezterm = require 'wezterm'
                    local config = {}

                    config.color_scheme = 'GruvboxDark'
                    config.font = wezterm.font('JetBrains Mono')
                    config.font_size = 14

                    return config
                  '';
                  
                  # LazyVim configuration
                  "nvim" = {
                    source = pkgs.fetchFromGitHub {
                      owner = "LazyVim";
                      repo = "starter";
                      rev = "main";
                      sha256 = "sha256-QrpnlDD4r1X4C8PqBhQ+S3ar5C+qDrU1Jm/lPqyMIFM=";
                    };
                    recursive = true;
                  };
                  
                  # Neovim plugins
                  "nvim/lua/plugins/colorscheme.lua".text = ''
                    return {
                      { "ellisonleao/gruvbox.nvim" },
                      {
                        "LazyVim/LazyVim",
                        opts = {
                          colorscheme = "gruvbox",
                        },
                      },
                    }
                  '';
                  
                  "nvim/lua/plugins/lsp.lua".text = ''
                    return {
                      {
                        "neovim/nvim-lspconfig",
                        opts = {
                          servers = {
                            nil_ls = {},
                          },
                        },
                      },
                      {
                        "stevearc/conform.nvim",
                        optional = true,
                        opts = {
                          formatters_by_ft = {
                            nix = { "nixfmt" },
                          },
                        },
                      },
                    }
                  '';
                };
              };
            };
          }
        ];
      };
    };
}
