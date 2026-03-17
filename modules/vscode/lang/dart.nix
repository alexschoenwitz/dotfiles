{ pkgs, ... }:
{
  extensions = with pkgs.vscode-extensions; [
    dart-code.dart-code
    dart-code.flutter
  ];
  settings = {
    "[dart]" = {
      "editor.formatOnType" = true;
      "editor.rulers" = [ 80 ];
      "editor.selectionHighlight" = false;
      "editor.tabCompletion" = "onlySnippets";
      "editor.wordBasedSuggestions" = "off";
    };
    "dart.devToolsBrowser" = true;
    "dart.openDevTools" = "flutter";
  };
}
