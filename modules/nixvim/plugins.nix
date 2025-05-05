{
  bufferline.enable = true;
  lualine.enable = true;
  render-markdown.enable = true;
  treesitter.enable = true;
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
          "snippet_forward"
          "select_next"
          "fallback"
        ];
        "<S-Tab>" = [
          "snippet_backward"
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
      {
        action = "previous";
        key = "<C-w>\\";
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
      explorer = {
        enabled = true;
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
    servers = {
      bashls.enable = true;
      gopls = {
        enable = true;
        settings.gopls = {
          gofumpt = true;
          codelenses = {
            gc_details = false;
            generate = true;
            regenerate_cgo = true;
            run_govulncheck = true;
            test = true;
            tidy = true;
            upgrade_dependency = true;
            vendor = true;
          };
          analyses = {
            nilness = true;
            unusedparams = true;
            unusedwrite = true;
            useany = true;
          };
          usePlaceholders = true;
          completeUnimported = true;
          staticcheck = true;
          directoryFilters = [
            "-.git"
            "-.vscode"
            "-.idea"
            "-.vscode-test"
            "-node_modules"
          ];
          semanticTokens = true;
        };
        onAttach.function = ''
          if not client.server_capabilities.semanticTokensProvider then
          local semantic = client.config.capabilities.textDocument.semanticTokens;
            client.server_capabilities.semanticTokensProvider = {
              full = true,
              legend = {
                tokenTypes = semantic.tokenTypes,
                tokenModifiers = semantic.tokenModifiers,
              },
              range = true,
            }
          end
        '';
      };
      ts_ls.enable = true;
      nixd.enable = true;
      html.enable = true;
      omnisharp = {
        enable = true;
        settings = {
          formattingOptions = {
            enableEditorConfigSupport = true;
            organizeImports = true;
          };
          roslynExtensionsOptions = {
            enableAnalyzersSupport = true;
          };
        };
        onAttach.function =
          #lua
          ''
            -- Custom command to populate quickfix with dotnet build errors
            vim.api.nvim_create_user_command("PopulateQuickfixDotnet", function()
              local project_dir = os.getenv("DOTNET_PROJECT_DIR") or "."
              local command_output = vim.fn.systemlist(string.format("dotnet build %s", project_dir))
              vim.fn.setqflist({}, "r")

              local quickfix_list = {}
              local seen_errors = {}

              for _, line in ipairs(command_output) do
                -- Adjusted regex slightly for robustness
                local filename, lnum, col, text = string.match(line, "^%s*([^%(]+)%((%d+),(%d+)%)%s*:%s*error%s*%w*%s*:%s*(.+)$")
                if filename and lnum and col and text then
                  -- Trim whitespace from text
                  text = vim.fn.trim(text)
                  local error_key = filename .. ":" .. lnum .. ":" .. col .. ":" .. text
                  if not seen_errors[error_key] then
                    seen_errors[error_key] = true
                    table.insert(quickfix_list, {
                      filename = filename,
                      lnum = tonumber(lnum),
                      col = tonumber(col),
                      text = text,
                      type = 'E', -- Explicitly mark as error
                    })
                  end
                end
              end

              if #quickfix_list > 0 then
                vim.fn.setqflist(quickfix_list, "r")
                vim.cmd("copen")
              else
                vim.notify("No dotnet build errors found", vim.log.levels.INFO)
                vim.cmd("cclose")
              end
            end, { desc = "Populate quickfix list with dotnet build errors" })

            -- Keymap for the custom command
            vim.keymap.set(
              "n",
              "<leader>l1",
              ":PopulateQuickfixDotnet<CR>",
              -- NOTE: bufnr might not be correct here if attaching globally.
              -- Consider removing buffer = bufnr if this should apply globally.
              { remap = false, silent = true, desc = "Populate dotnet errors" }
              -- { buffer = bufnr, remap = false, silent = true, desc = "Populate dotnet errors" }
            )

            -- Override with command for extended
            vim.keymap.set(
              "n",
              "gd",
              "<cmd>lua require('omnisharp_extended').lsp_definition()<cr>",
              { buffer = bufnr, remap = false, silent = true, desc = "LSP: [G]oto [D]efinition (OmniSharp Extended)" }
            )
          '';
      };
    };
  };

  conform-nvim = {
    enable = true;
    settings = {
      format_on_save = {
        timeoutMs = 2000;
      };

      formatters_by_ft = {
        nix = [ "nixfmt" ];
        cs = [ "csharpier" ];
        go = [
          "gofumpt"
          "goimports"
        ];
        rust = [ "rustfmt" ];
        typescript = [ "prettierd" ];
        typescriptreact = [ "prettierd" ];
        javascript = [ "prettierd" ];
        javascriptreact = [ "prettierd" ];
        json = [ "prettierd" ];
        html = [ "prettierd" ];
        css = [ "prettierd" ];
        hcl = [ "packer_fmt" ];
        terraform = [ "terraform_fmt" ];
        tf = [ "terraform_fmt" ];
      };
    };
  };
}
