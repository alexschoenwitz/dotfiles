{ pkgs, ... }:
{
  extensions = with pkgs.vscode-extensions; [ foxundermoon.shell-format ];
  settings = {
    "[shellscript]"."editor.defaultFormatter" = "foxundermoon.shell-format";
  };
}
