{ pkgs, ... }:
{
  home.packages =
    (import ./lang/go/default.nix { inherit pkgs; }).home.packages
    ++ (import ./lang/rust/default.nix { inherit pkgs; }).home.packages
    ++ (import ./lang/csharp/default.nix { inherit pkgs; }).home.packages;
}
