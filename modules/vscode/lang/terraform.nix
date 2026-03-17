{ pkgs, ... }:
{
  extensions = with pkgs.vscode-extensions; [ hashicorp.terraform ];
  settings = {
    "[terraform]"."editor.formatOnSave" = true;
    "[terraform-vars]"."editor.formatOnSave" = true;
  };
}
