{ pkgs, ... }:
{
  home.packages = [
    pkgs._1password-cli
    pkgs.aerospace
    pkgs.colima
    pkgs.curl
    pkgs.docker
    pkgs.docker-compose
    pkgs.eza
    pkgs.fzf
    pkgs.ghostty-bin
    pkgs.git
    pkgs.gnupg
    pkgs.grpcui
    pkgs.grpcurl
    pkgs.jq
    pkgs.ripgrep
    pkgs.tmux
    pkgs.tree
    pkgs.websocat
    pkgs.zoxide

    # General development tools
    pkgs.clang-tools # clangd lsp for C/C++
    pkgs.terraform-ls
    pkgs.tflint
    pkgs.tree-sitter
  ];
}
