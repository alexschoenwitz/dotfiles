{ user, lib, pkgs, ... }:
{
  imports = [
    ../../modules/home.nix
    ../../modules/atuin.nix
    ../../modules/claude-code
    ../../modules/theme/colors.nix
    ../../modules/direnv.nix
    ../../modules/git
    ../../modules/kubernetes
    ../../modules/pkgs.nix
    ../../modules/tmux
    ../../modules/zsh
  ];

  programs.neovim.enable = true;

  home.packages = lib.mkForce (with pkgs; [
    _1password-cli
    curl
    envsubst
    eza
    fd
    gh
    hcloud
    hugo
    jq
    just
    ripgrep
    tree
    yq
  ]);

  programs.git.settings.user.email = "alexandre.schoenwitz@gmail.com";
  programs.git.signing.signByDefault = lib.mkForce false;
}
