{ pkgs, ... }:
{
  home.packages = [
    pkgs.go
    pkgs.gofumpt
    pkgs.gopls
    pkgs.gotools
  ];
}
