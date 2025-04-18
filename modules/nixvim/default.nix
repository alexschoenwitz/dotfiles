{ pkgs, ... }:
{
  imports = [ ./options.nix ];
  programs.nixvim = {
    enable = true;
    plugins = import ./plugins.nix;
    keymaps = import ./keymaps.nix;
    extraPlugins = with pkgs.vimPlugins; [
      omnisharp-extended-lsp-nvim
    ];
  };
}
