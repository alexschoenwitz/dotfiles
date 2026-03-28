{ pkgs, ... }:
{
  home.packages = with pkgs; [
    flutter
    protoc-gen-dart
  ];
}
