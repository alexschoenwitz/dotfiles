{ config, pkgs, ... }:

let
  # Gruvbox theme for Oh-My-Zsh
  gruvbox-zsh-theme = pkgs.fetchFromGitHub {
    owner = "sbugzu";
    repo = "gruvbox-zsh";
    rev = "c54443c8d3da35037b7ae3ca73b30b45bc91a9e7";
    sha256 = "sha256-pxG2PCw4hAgqu1T9DVjqdHM1t4g32B+N4URmAtoVdsU=";
  };
in {
  home.packages =
    [ pkgs.zsh pkgs.bat pkgs.ripgrep pkgs.nil pkgs.nixfmt-classic pkgs.cargo ];

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      oh-my-zsh = {
        enable = true;
        # Remove the theme property here
        plugins = [ "git" "sudo" ];
      };

      initExtra = ''
        # Source the gruvbox theme directly
        source ${gruvbox-zsh-theme}/gruvbox.zsh-theme

        # Set gruvbox theme configuration
        SOLARIZED_THEME="dark"
        GRUVBOX_DARK_PALETTE="dark"
      '';
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };

  # Custom themes need to be installed in the oh-my-zsh custom themes directory
  xdg.configFile."oh-my-zsh/custom/themes/gruvbox.zsh-theme".source =
    "${gruvbox-zsh-theme}/gruvbox.zsh-theme";

  # Add gruvbox theme for wezterm
  xdg.configFile = {
    "wezterm/wezterm.lua".text = ''
      local wezterm = require 'wezterm'
      local config = {}

      config.color_scheme = 'GruvboxDark'
      config.font = wezterm.font('JetBrains Mono')
      config.font_size = 14

      return config
    '';

    # Set up LazyVim
    "nvim" = {
      source = pkgs.fetchFromGitHub {
        owner = "LazyVim";
        repo = "starter";
        rev = "main"; # You might want to pin this to a specific commit
        sha256 =
          "sha256-QrpnlDD4r1X4C8PqBhQ+S3ar5C+qDrU1Jm/lPqyMIFM="; # Replace with the actual hash
      };
      recursive = true;
    };

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

  programs.git = {
    enable = true;
    userName = "Alexandre Schönwitz";
    userEmail = "alexandre.schoenwitz@gmail.com";
  };
}
