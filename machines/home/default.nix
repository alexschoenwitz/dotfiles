{ pkgs, ... }:
{
  imports = [
    ../shared/darwin.nix
  ];
  home-manager.users."alexandre.schoenwitz".home.packages = with pkgs; [
    aider-chat
  ];
}
