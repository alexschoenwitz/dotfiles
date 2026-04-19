{ pkgs, ... }:
{
  home.packages = [
    pkgs.go
    pkgs.gofumpt
    pkgs.gopls
    (pkgs.lib.lowPrio pkgs.gotools)
  ];
}
