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
      fzf
      git
      grpcurl
      imagemagick
      jq
      kubectl
      lazygit
      ripgrep
      websocat
      zsh-autosuggestions
      zsh-powerlevel10k

      # required by snacks.image
      ghostscript
      tectonic
      mermaid-cli
      fd

      # treesitter, lsps, formatters, etc
      bash-language-server
      clang-tools # clangd lsp
      gofumpt
      gotools
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
      shfmt
      gopls
      csharpier
      terraform-ls

      # Rust tools
      rustc
      rustfmt
      rust-analyzer
      clippy
    ];
}
