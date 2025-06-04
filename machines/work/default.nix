{ pkgs, ... }:
{
  imports = [ ../shared/darwin.nix ];
  home-manager.users."alexandre.schoenwitz".programs.git.userEmail =
    "alexandre.schoenwitz@freiheit.com";
  home-manager.users."alexandre.schoenwitz".programs.git.extraConfig.user.signingKey =
    "~/.ssh/id_rsa";
}
