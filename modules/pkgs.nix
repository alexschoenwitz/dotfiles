{ pkgs, ... }:
{
  home.packages = [
    pkgs._1password-cli
    pkgs.aerospace
    pkgs.colima
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

    # General development tools
    pkgs.clang-tools # clangd lsp for C/C++
    pkgs.terraform-ls
    pkgs.tflint
    pkgs.tree-sitter
  ];
}
