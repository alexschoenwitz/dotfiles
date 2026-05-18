{ user, lib, ... }:
{
  imports = [
    ../../modules/home.nix
    ../../modules/atuin.nix
    ../../modules/claude-code
    ../../modules/theme/colors.nix
    ../../modules/direnv.nix
    ../../modules/git
    ../../modules/kubernetes
    ../../modules/nixvim
    ../../modules/pkgs.nix
    ../../modules/protobuf
    ../../modules/lang.nix
    ../../modules/tmux
    ../../modules/zsh
  ];

  programs.git.settings.user.email = "alexandre.schoenwitz@gmail.com";
  programs.git.signing.signByDefault = lib.mkForce false;
}
