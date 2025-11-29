{ pkgs, ... }:
{
  home.packages =
    (import ./lang/bash/default.nix { inherit pkgs; }).home.packages
    ++ (import ./lang/csharp/default.nix { inherit pkgs; }).home.packages
    ++ (import ./lang/go/default.nix { inherit pkgs; }).home.packages
    ++ (import ./lang/lua/default.nix { inherit pkgs; }).home.packages
    ++ (import ./lang/nix/default.nix { inherit pkgs; }).home.packages
    ++ (import ./lang/python/default.nix { inherit pkgs; }).home.packages
    ++ (import ./lang/rust/default.nix { inherit pkgs; }).home.packages
    ++ (import ./lang/typescript/default.nix { inherit pkgs; }).home.packages;
}
