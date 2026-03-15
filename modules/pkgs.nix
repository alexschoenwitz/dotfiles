{ pkgs, llm-agents-pkgs, ... }:
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
    gh
    gnupg
    jq
    mosquitto
    postgresql
    ranger
    ripgrep
    sqlx-cli
    tree
    websocat

    llm-agents-pkgs.rtk
  ];
in
{
  home.packages = sharedPackages ++ (if pkgs.stdenv.isDarwin then darwinOnlyPackages else [ ]);
}
