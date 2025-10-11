{
  lsp = {
    servers = {
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
    };
  };
  conform-nvim = {
    settings = {
      formatters_by_ft = {
        go = [
          "gofumpt"
          "goimports"
        ];
      };
    };
  };
}
