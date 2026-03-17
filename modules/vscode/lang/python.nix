{ pkgs, ... }:
{
  extensions = with pkgs.vscode-extensions; [
    ms-python.python
    charliermarsh.ruff
  ];
  settings = {
    "[python]"."editor.defaultFormatter" = "charliermarsh.ruff";
  };
}
