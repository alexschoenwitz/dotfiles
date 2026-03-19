{ config, lib, pkgs, ... }:
let
  p = config.theme.palette;
in
{
  config = lib.mkIf pkgs.stdenv.isDarwin {
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
    background = #${p.base00}
    foreground = #${p.base05}
    cursor-color = #${p.base05}
    selection-background = #${p.base02}
    selection-foreground = #${p.base05}
    palette = 0=#${p.base00}
    palette = 1=#${p.base08}
    palette = 2=#${p.base0B}
    palette = 3=#${p.base0A}
    palette = 4=#${p.base0D}
    palette = 5=#${p.base0E}
    palette = 6=#${p.base0C}
    palette = 7=#${p.base05}
    palette = 8=#${p.base03}
    palette = 9=#${p.base08}
    palette = 10=#${p.base0B}
    palette = 11=#${p.base0A}
    palette = 12=#${p.base0D}
    palette = 13=#${p.base0E}
    palette = 14=#${p.base0C}
    palette = 15=#${p.base07}
  '';
  };
}
