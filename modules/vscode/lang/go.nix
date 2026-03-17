{ pkgs, ... }:
{
  extensions = with pkgs.vscode-extensions; [ golang.go ];
  settings = {
    "[go]" = {
      "editor.defaultFormatter" = "golang.go";
      "editor.codeActionsOnSave"."source.organizeImports" = "explicit";
    };
    "gopls"."formatting.gofumpt" = true;
  };
}
