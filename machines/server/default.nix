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

  programs.git.settings.user.email = "alexandre.schoenwitz@gmail.com";
  programs.git.signing.signByDefault = lib.mkForce false;
}
