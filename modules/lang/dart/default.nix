{ pkgs, ... }:
{
  home.packages = with pkgs; [
    flutter338
    protoc-gen-dart
  ];
}
