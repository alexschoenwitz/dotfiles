{ pkgs, ... }:
{
  home.packages =
    with pkgs;
    with pkgs.nodePackages_latest;
    [
      _1password-cli
      argocd
      cargo
      colima
      curl
      docker
      docker-compose
      git
      grpcurl
      imagemagick
      jq
      kubectl
      ripgrep
      websocat
      zsh-autosuggestions
      zsh-powerlevel10k

      # treesitter, lsps, formatters, etc
      bash-language-server
      clang-tools # clangd lsp
      gofumpt
      nil # nix lsp
      nixfmt-rfc-style
      prettier
      lua-language-server
      prettierd
      shellcheck
      stylua
      tree-sitter
      typescript-language-server
      yaml-language-server
      yamllint
      dotnet-sdk
      gopls
      csharpier

      # Rust tools
      rustc
      rustfmt
      rust-analyzer
      clippy
    ];
}
