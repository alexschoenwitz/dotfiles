{ pkgs, ... }:
{
  home.packages = [
    pkgs._1password-cli
    pkgs.aerospace
    pkgs.colima
    pkgs.direnv
    pkgs.docker
    pkgs.docker-compose
    pkgs.curl
    pkgs.eza
    pkgs.fzf
    pkgs.git
    pkgs.gnupg
    pkgs.ripgrep
    pkgs.tmux
    pkgs.tree
    pkgs.zoxide

    pkgs.grpcurl
    pkgs.grpcui
    pkgs.jq
    pkgs.websocat

    # treesitter, lsps, formatters, etc
    pkgs.bash-language-server
    pkgs.clang-tools # clangd lsp
    pkgs.lua-language-server
    pkgs.nil # nix lsp
    pkgs.nixfmt-rfc-style
    pkgs.prettier
    pkgs.prettierd
    pkgs.shellcheck
    pkgs.shfmt
    pkgs.stylua
    pkgs.terraform-ls
    pkgs.tflint
    pkgs.tree-sitter
    pkgs.typescript-language-server
  ];
}
