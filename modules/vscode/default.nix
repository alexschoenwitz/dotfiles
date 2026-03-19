{ pkgs, lib, config, ... }:
let
  langModules = map (f: import f { inherit pkgs; }) [
    ./lang/bash.nix
    ./lang/csharp.nix
    ./lang/dart.nix
    ./lang/go.nix
    ./lang/nix.nix
    ./lang/python.nix
    ./lang/rust.nix
    ./lang/terraform.nix
    ./lang/typescript.nix
  ];

  commonExtensions = (import ./extensions.nix { inherit pkgs; }).extensions;
  allExtensions = commonExtensions ++ lib.concatMap (m: m.extensions) langModules;

  p = config.theme.paletteHash;

  baseSettings = (import ./settings.nix { }).userSettings;
  langSettings = lib.foldl lib.recursiveUpdate { } (map (m: m.settings) langModules);
  themeSettings = {
    "workbench.colorTheme" = "Default Dark Modern";
    "workbench.colorCustomizations" = {
      "editor.background" = p.base00;
      "editor.foreground" = p.base05;
      "editorLineNumber.foreground" = p.base03;
      "editorLineNumber.activeForeground" = p.base04;
      "editor.selectionBackground" = p.base02;
      "editor.inactiveSelectionBackground" = p.base01;
      "editorCursor.foreground" = p.base05;
      "activityBar.background" = p.base00;
      "activityBar.foreground" = p.base04;
      "sideBar.background" = p.base01;
      "sideBar.foreground" = p.base05;
      "statusBar.background" = p.base01;
      "statusBar.foreground" = p.base04;
      "titleBar.activeBackground" = p.base00;
      "titleBar.activeForeground" = p.base05;
      "tab.activeBackground" = p.base00;
      "tab.inactiveBackground" = p.base01;
      "tab.activeForeground" = p.base05;
      "tab.inactiveForeground" = p.base03;
      "panel.background" = p.base00;
      "terminal.background" = p.base00;
      "terminal.foreground" = p.base05;
      "editorWidget.background" = p.base01;
      "input.background" = p.base01;
      "focusBorder" = p.base0D;
      "list.activeSelectionBackground" = p.base02;
      "list.hoverBackground" = p.base01;
      "editorGutter.addedBackground" = p.base0B;
      "editorGutter.modifiedBackground" = p.base0D;
      "editorGutter.deletedBackground" = p.base08;
    };
    "editor.tokenColorCustomizations" = {
      "textMateRules" = [
        { scope = "comment"; settings = { foreground = p.base03; fontStyle = "italic"; }; }
        { scope = "string"; settings.foreground = p.base0B; }
        { scope = [ "constant.numeric" "constant.language" ]; settings.foreground = p.base09; }
        { scope = [ "keyword" "storage.type" "storage.modifier" ]; settings.foreground = p.base0D; }
        { scope = "entity.name.function"; settings.foreground = p.base0D; }
        { scope = [ "entity.name.type" "entity.name.class" ]; settings.foreground = p.base0A; }
        { scope = [ "entity.name.namespace" "entity.name.tag" "variable.other.object" ]; settings.foreground = p.base08; }
        { scope = "support.function"; settings.foreground = p.base0C; }
        { scope = "variable.parameter"; settings.foreground = p.base05; }
        { scope = "invalid"; settings.foreground = p.base08; }
      ];
    };
    # Semantic tokens (used by C#, Rust, Go, etc.) — maps the same base16 palette
    # so language-server-provided highlights match TextMate rules above.
    "editor.semanticTokenColorCustomizations" = {
      "rules" = {
        "comment" = { foreground = p.base03; italic = true; };
        "string" = p.base0B;
        "number" = p.base09;
        "keyword" = p.base0D;
        "type" = p.base0A;
        "class" = p.base0A;
        "struct" = p.base0A;
        "interface" = p.base0C;
        "typeParameter" = p.base0A;
        "enum" = p.base0A;
        "enumMember" = p.base09;
        "namespace" = p.base08;
        "function" = p.base0D;
        "method" = p.base0D;
        "macro" = p.base0C;
        "decorator" = p.base09;
        "field" = p.base0A;
        "property" = p.base05;
        "variable" = p.base05;
        "parameter" = p.base05;
        "selfKeyword" = p.base0E;
      };
    };
  };
  mergedSettings = lib.foldl lib.recursiveUpdate { } [
    baseSettings
    langSettings
    themeSettings
  ];
in
{
  config = lib.mkIf pkgs.stdenv.isDarwin {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode;
      mutableExtensionsDir = true;
      profiles.default = {
        extensions = allExtensions;
        userSettings = mergedSettings;
        keybindings = import ./keybindings.nix;
      };
    };
  };
}
