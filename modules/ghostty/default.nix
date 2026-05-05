{
  config,
  lib,
  pkgs,
  ...
}:
let
  # Gruvbox canonical ANSI colors (from the gruvbox project).
  # Normal = neutral variants, Bright = faded/bright variants per mode.
  # These differ from the base16 mapping which only has one set.
  darkTheme = ''
    background = #282828
    foreground = #ebdbb2
    cursor-color = #ebdbb2
    cursor-text = #282828
    selection-background = #504945
    selection-foreground = #ebdbb2
    palette = 0=#282828
    palette = 1=#cc241d
    palette = 2=#98971a
    palette = 3=#d79921
    palette = 4=#458588
    palette = 5=#b16286
    palette = 6=#689d6a
    palette = 7=#a89984
    palette = 8=#928374
    palette = 9=#fb4934
    palette = 10=#b8bb26
    palette = 11=#fabd2f
    palette = 12=#83a598
    palette = 13=#d3869b
    palette = 14=#8ec07c
    palette = 15=#ebdbb2
  '';

  lightTheme = ''
    background = #fbf1c7
    foreground = #3c3836
    cursor-color = #3c3836
    cursor-text = #fbf1c7
    selection-background = #3c3836
    selection-foreground = #fbf1c7
    palette = 0=#fbf1c7
    palette = 1=#cc241d
    palette = 2=#98971a
    palette = 3=#d79921
    palette = 4=#458588
    palette = 5=#b16286
    palette = 6=#689d6a
    palette = 7=#7c6f64
    palette = 8=#928374
    palette = 9=#9d0006
    palette = 10=#79740e
    palette = 11=#b57614
    palette = 12=#076678
    palette = 13=#8f3f71
    palette = 14=#427b58
    palette = 15=#3c3836
  '';
in
{
  config = lib.mkIf pkgs.stdenv.isDarwin {
    xdg.configFile."ghostty/themes/gruvbox-dark".text = darkTheme;
    xdg.configFile."ghostty/themes/gruvbox-light".text = lightTheme;

    xdg.configFile."ghostty/config".text = ''
      clipboard-paste-protection = false
      clipboard-read = allow
      font-family = Noto Sans Mono
      font-size = 18
      mouse-hide-while-typing = true
      scrollback-limit = 1000000
      shell-integration = zsh
      window-save-state = always
      window-theme = ghostty
      fullscreen = true
      macos-non-native-fullscreen = true
      macos-titlebar-style = hidden
      macos-option-as-alt = true
      keybind = shift+enter=text:\n
      theme = light:gruvbox-light,dark:gruvbox-dark
    '';
  };
}
