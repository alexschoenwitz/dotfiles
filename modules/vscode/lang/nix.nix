{ pkgs, ... }:
{
  extensions = with pkgs.vscode-extensions; [ jnoortheen.nix-ide ];
  settings = {
    "[nix]" = {
      "editor.formatOnSave" = true;
      "editor.defaultFormatter" = "jnoortheen.nix-ide";
    };
    "nix.enableLanguageServer" = true;
    "nix.serverPath" = "nixd";
    "nix.serverSettings" = {
      "nixd" = {
        "formatting" = {
          "command" = [ "nixfmt" ];
        };
      };
    };
  };
}
