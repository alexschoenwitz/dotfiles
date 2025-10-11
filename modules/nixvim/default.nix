{ pkgs, ... }:
{
  imports = [ ./options.nix ];
  programs.nixvim = {
    enable = true;
    plugins =
      (import ./plugins.nix)
      // (import ./lang/bash.nix)
      // (import ./lang/go.nix)
      // (import ./lang/typescript.nix)
      // (import ./lang/dart.nix)
      // (import ./lang/nix.nix)
      // (import ./lang/html.nix)
      // (import ./lang/csharp.nix)
      // (import ./lang/rust.nix);
    extraPlugins = with pkgs.vimPlugins; [
      omnisharp-extended-lsp-nvim
    ];
    keymaps = import ./keymaps.nix;
    colorschemes.gruvbox.enable = true;
  };
}
