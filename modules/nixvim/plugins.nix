{
  render-markdown.enable = true;
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
      };
    };
  };
  trouble.enable = true;
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
      picker.enabled = true;
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
        timeoutMs = 2000;
      };
    };
  };
}
