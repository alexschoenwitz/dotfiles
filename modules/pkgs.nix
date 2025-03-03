{ pkgs, ... }:
let
  darwinOnlyPackages = with pkgs; [
    aerospace
    colima
    ghostty-bin
  ];

  sharedPackages = with pkgs; [
    _1password-cli
    curl
    docker
    docker-compose
    eza
    fzf
    git
    gnupg
    grpcui
    grpcurl
    jq
    ripgrep
    tmux
    tree
    websocat
    zoxide

    # General development tools
    clang-tools # clangd lsp for C/C++
    terraform-ls
    tflint
    tree-sitter
  ];
in
{
  home.packages = sharedPackages ++ (if pkgs.stdenv.isDarwin then darwinOnlyPackages else [ ]);
}
