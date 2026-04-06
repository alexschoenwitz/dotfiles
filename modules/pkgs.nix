{ pkgs, ... }:
let
  darwinOnlyPackages = with pkgs; [
    aerospace
    brave
    colima
    ghostty-bin
    insomnia
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
    fd
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
  ];
in
{
  home.packages = sharedPackages ++ (if pkgs.stdenv.isDarwin then darwinOnlyPackages else [ ]);
}
