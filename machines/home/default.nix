{ pkgs, ... }:
{
  imports = [ ../shared/darwin.nix ];
  home-manager.users."alexandre.schoenwitz".programs.git.userEmail = "alexandre.schoenwitz@gmail.com";
  home-manager.users."alexandre.schoenwitz".programs.git.extraConfig.user.signingKey =
    "~/.ssh/id_ed25519";
}
