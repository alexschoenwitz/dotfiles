{ pkgs, llm-agents-pkgs, ... }:
let
  darwinOnlyPackages = with pkgs; [
    aerospace
    brave
    colima
    ghostty-bin
  ];

  sharedPackages = with pkgs; [
    _1password-cli
    _1password-gui
    awscli2
    curl
    docker
    docker-compose
    envsubst
    eza
    gh
    gnupg
    jq
    just
    jwt-cli
    lcov
    mosquitto
    openfga-cli
    postgresql
    ranger
    ripgrep
    sqlx-cli
    tree
    websocat
    yq

    llm-agents-pkgs.rtk
  ];
in
{
  home.packages = sharedPackages ++ (if pkgs.stdenv.isDarwin then darwinOnlyPackages else [ ]);
}
