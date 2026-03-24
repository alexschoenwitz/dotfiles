{ pkgs, ... }:
let
  toolchain = pkgs.fenix.combine [
    pkgs.fenix.stable.cargo
    pkgs.fenix.stable.clippy
    pkgs.fenix.stable.rustc
    pkgs.fenix.stable.rustfmt
    pkgs.fenix.stable.rust-src
    pkgs.fenix.targets.aarch64-unknown-linux-gnu.stable.rust-std
    pkgs.fenix.targets.wasm32-unknown-unknown.stable.rust-std
  ];
in
{
  home.packages = [
    toolchain
    pkgs.rust-analyzer
    pkgs.cargo-zigbuild
    pkgs.zig
    pkgs.trunk
  ];
}
