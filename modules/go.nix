{ pkgs, ... }:
{
  programs.go = {
    enable = true;
    package = pkgs.go_1_24;
    goPath = "Projects/Go";
  };
}
