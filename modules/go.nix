{ pkgs, ... }:
{
  programs.go = {
    enable = true;
    package = pkgs.go_1_24;
    GOPATH = "Projects/Go";
  };
}
