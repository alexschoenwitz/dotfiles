{ pkgs, ... }:
{
  home.packages = [
    pkgs.gofumpt
    pkgs.gopls
    pkgs.gotools
  ];
}
