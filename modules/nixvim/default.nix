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
    '';
  };
}
