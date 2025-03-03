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
in
{
  imports = [ ./options.nix ];
  programs.nixvim = {
    enable = true;
    plugins = mergedPlugins;
    extraPlugins = with pkgs.vimPlugins; [
      omnisharp-extended-lsp-nvim
      base16-nvim
    ];
    keymaps = import ./keymaps.nix;

    extraConfigLua = ''
      require('base16-colorscheme').setup('gruvbox-dark-medium')

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
