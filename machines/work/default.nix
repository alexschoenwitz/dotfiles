{ pkgs, ... }:
{
  imports = [ ../shared/darwin.nix ];
  home-manager.users."alexandre.schoenwitz".programs.git.userEmail =
    "alexandre.schoenwitz@freiheit.com";
}
