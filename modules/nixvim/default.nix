{ pkgs, lib, ... }:
let
  recursiveMerge = lib.recursiveUpdate;
  pluginSets = [
    (import ./plugins.nix)
    (import ./lang/bash.nix)
    (import ./lang/csharp.nix)
    (import ./lang/dart.nix)
    (import ./lang/go.nix)
    (import ./lang/html.nix)
    (import ./lang/nix.nix)
    (import ./lang/python.nix)
    (import ./lang/rust.nix)
    (import ./lang/typescript.nix)
  ];
  mergedPlugins = lib.foldl recursiveMerge { } pluginSets;

  auto-dark-mode-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "auto-dark-mode-nvim";
    version = "2025-04-15";
    src = pkgs.fetchFromGitHub {
      owner = "f-person";
      repo = "auto-dark-mode.nvim";
      rev = "54058b4fe414bd64bd2904a6f8a63f1f14e3d8df";
      hash = "sha256-xTgRyct3L6Gcz/vdYSc+h2IUgi/+Lh1Q4mxJwHISeis=";
    };
  };
in
{
  imports = [ ./options.nix ];
  programs.nixvim = {
    enable = true;
    plugins = mergedPlugins;
    extraPlugins = with pkgs.vimPlugins; [
      omnisharp-extended-lsp-nvim
      base16-nvim
      auto-dark-mode-nvim
    ];
    keymaps = import ./keymaps.nix;

    extraConfigLua = ''
      require('auto-dark-mode').setup({
        set_dark_mode = function()
          vim.o.background = 'dark'
          vim.cmd.colorscheme('base16-gruvbox-dark-medium')
        end,
        set_light_mode = function()
          vim.o.background = 'light'
          vim.cmd.colorscheme('base16-gruvbox-light-medium')
        end,
      })

      -- Fix navigation in snacks explorer (floating window confuses smart-splits)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "snacks_picker_list", "snacks_picker_input" },
        callback = function()
          local opts = { buffer = true, silent = true }
          -- C-l: go to window on the right (editor)
          vim.keymap.set("n", "<C-l>", "<cmd>wincmd l<cr>", opts)
          -- C-h: go to tmux pane on the left (or do nothing if no pane)
          vim.keymap.set("n", "<C-h>", function()
            vim.fn.system("tmux select-pane -L")
          end, opts)
        end,
      })
    '';
  };
}
