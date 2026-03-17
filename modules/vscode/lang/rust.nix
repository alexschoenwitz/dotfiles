{ pkgs, ... }:
{
  extensions = with pkgs.vscode-extensions; [ rust-lang.rust-analyzer ];
  settings = {
    "[rust]"."editor.defaultFormatter" = "rust-lang.rust-analyzer";
  };
}
