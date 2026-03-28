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
    dotnetCorePackages.sdk_10_0-bin
    envsubst
    eza
    flutter
    gh
    gnupg
    jq
    just
    jwt-cli
    lcov
    mosquitto
    openfga-cli
    postgresql
    protoc-gen-dart
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
