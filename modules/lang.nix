{ pkgs, ... }:
{
  home.packages =
    (import ./lang/bash/default.nix { pkgs = pkgs; }).home.packages
    ++ (import ./lang/csharp/default.nix { pkgs = pkgs; }).home.packages
    ++ (import ./lang/go/default.nix { pkgs = pkgs; }).home.packages
    ++ (import ./lang/lua/default.nix { pkgs = pkgs; }).home.packages
    ++ (import ./lang/nix/default.nix { pkgs = pkgs; }).home.packages
    ++ (import ./lang/python/default.nix { pkgs = pkgs; }).home.packages
    ++ (import ./lang/rust/default.nix { pkgs = pkgs; }).home.packages
    ++ (import ./lang/typescript/default.nix { pkgs = pkgs; }).home.packages;
}
