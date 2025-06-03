{ pkgs, ... }:
{
  home.packages =
    with pkgs;
    with pkgs.nodePackages_latest;
    [
      _1password-cli
      argocd
      buf
      cargo
      colima
      curl
      direnv
      docker
      docker-compose
      evans
      fzf
      google-cloud-sdk
      git
      gnupg
      grpcurl
      imagemagick
      jq
      kubectl
      lazygit
      nodejs
      postgresql_17_jit
      ripgrep
      terraform
      tmux
      tree
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
      csharpier
      dotnet-sdk_9
      gofumpt
      gopls
      gotools
      lua-language-server
      nil # nix lsp
      nixfmt-rfc-style
      prettier
      prettierd
      shellcheck
      shfmt
      stylua
      terraform-ls
      tflint
      tree-sitter
      typescript-language-server
      yaml-language-server
      yamllint

      # Rust tools
      rustc
      rustfmt
      rust-analyzer
      clippy
    ];
}
