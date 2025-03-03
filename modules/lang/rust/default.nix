{ pkgs, ... }:
{
  home.packages = [
    pkgs.cargo
    pkgs.rustc
    pkgs.rustfmt
    pkgs.rust-analyzer
    pkgs.clippy
  ];
}
