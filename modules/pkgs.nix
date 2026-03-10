{ pkgs, llm-agents-pkgs, ... }:
let
  darwinOnlyPackages = with pkgs; [
    aerospace
    colima
    ghostty-bin
  ];

  sharedPackages = with pkgs; [
    _1password-cli
    buf
    curl
    docker
    docker-compose
    eza
    fzf
    gh
    git
    gnupg
    grpcui
    grpcurl
    istioctl
    jq
    k9s
    kubectl
    protobuf
    postgresql
    ripgrep
    skaffold
    sqlx-cli
    tmux
    tree
    websocat
    zoxide

    # General development tools
    clang-tools # clangd lsp for C/C++
    terraform-ls
    tflint
    tree-sitter

    nodejs-slim
    nodePackages.npm # brings npx with it

    uv

    llm-agents-pkgs.rtk
    kind
  ];
in
{
  home.packages = sharedPackages ++ (if pkgs.stdenv.isDarwin then darwinOnlyPackages else [ ]);
}
