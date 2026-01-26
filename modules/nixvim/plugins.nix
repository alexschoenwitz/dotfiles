{
  render-markdown.enable = true;
  mini = {
    enable = true;
    mockDevIcons = true;
    modules = {
      icons = { };
      surround = { };
    };
  };
  treesitter = {
    enable = true;
    settings = {
      auto_install = false;
      sync_install = false;
      highlight = {
        enable = true;
      };
      incremental_selection = {
        enable = true;
      };
      indent = {
        enable = true;
      };
    };
  };
  web-devicons.enable = true;
  which-key.enable = true;
  blink-cmp = {
    enable = true;
    settings = {
      keymap = {
        preset = "enter";
        "<CR>" = [
          "accept"
          "fallback"
        ];
        "<Tab>" = [
          "select_next"
          "fallback"
        ];
        "<S-Tab>" = [
          "select_prev"
          "fallback"
        ];
        "<C-j>" = [
          "select_next"
          "fallback"
        ];
        "<C-k>" = [
          "select_prev"
          "fallback"
        ];
      };
      sources = {
        default = [
          "lsp"
          "path"
          "snippets"
          "buffer"
        ];
        cmdline = [ ];
      };
    };
  };
  nvim-autopairs = {
    enable = true;
    settings = {
      check_ts = true;
    };
  };
  inc-rename = {
    enable = true;
  };
  trouble.enable = true;
  smart-splits = {
    enable = true;
  };
  tmux-navigator = {
    enable = true;
    keymaps = [
      {
        action = "left";
        key = "<C-w>h";
      }
      {
        action = "down";
        key = "<C-w>j";
      }
      {
        action = "up";
        key = "<C-w>k";
      }
      {
        action = "right";
        key = "<C-w>l";
      }
    ];
  };
  snacks = {
    enable = true;
    settings = {
      explorer = {
        enabled = true;
        cwd = "vim.uv.cwd()";
      };
      picker = {
        enabled = true;
        layout = {
          preset = "ivy";
        };
        win = {
          preview = {
            wo = {
              number = false;
              relativenumber = false;
            };
          };
        };
        formatters = {
          file = {
            filename_first = true;
            truncate = "left";
            min_width = 40;
          };
        };
        sources = {
          grep = {
            cmd = "rg";
          };
        };
      };
      toggle = {
        enabled = true;
        settings = {
          which-key = true;
        };
      };
    };
  };
  gitsigns = {
    enable = true;
    settings = {
      current_line_blame = true;
    };
  };
  lsp = {
    enable = true;
    inlayHints = true;
    capabilities = ''
      capabilities.textDocument.semanticTokens = nil
    '';
  };
  conform-nvim = {
    enable = true;
    settings = {
      format_on_save = {
        lsp_format = "fallback";
        timeout_ms = 2000;
      };
    };
  };
}
