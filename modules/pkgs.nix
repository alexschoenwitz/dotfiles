{ pkgs, ... }:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  home.packages =
    with pkgs;
    with pkgs.nodePackages_latest;
    [
      _1password-cli
      argocd
      bat
      brave
      cargo
      curl
      git
      jq
      kubectl
      neovim
      ripgrep
      zsh

      # treesitter, lsps, formatters, etc
      bash-language-server
      clang-tools # clangd lsp
      gofumpt
      nil # nix lsp
      nixfmt-rfc-style
      prettier
      shellcheck
      stylua
      tree-sitter
      typescript-language-server
      yaml-language-server
      yamllint
    ];
}
