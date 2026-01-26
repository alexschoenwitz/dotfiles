{
  lsp.servers.omnisharp = {
    enable = true;
    extraOptions = {
      cmd = [
        "omnisharp"
        "-z"
        "DotNet:enablePackageRestore=false"
        "--encoding"
        "utf-8"
        "--languageserver"
      ];
    };
    settings = {
      FormattingOptions = {
        EnableEditorConfigSupport = true;
        OrganizeImports = true;
      };
      MsBuild = {
        LoadProjectsOnDemand = true;
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
}
