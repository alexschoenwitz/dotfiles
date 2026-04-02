{ pkgs, lib, ... }:
let
  # `dart run` fails in Flutter workspaces because the Nix `dart` binary
  # has no FLUTTER_ROOT set (unlike the `flutter` wrapper script), causing
  # pub resolution to fall back to plain dart pub and fail on Flutter SDK
  # constraints. See: https://github.com/dart-lang/sdk/issues/62808
  dart-flutter = pkgs.writeShellScriptBin "dart" ''
    export FLUTTER_ROOT="${pkgs.flutter338}"
    exec "${pkgs.flutter338}/bin/dart" "$@"
  '';
in
{
  home.packages = with pkgs; [
    flutter338
    protoc-gen-dart
    (lib.hiPrio dart-flutter)
  ];
}
