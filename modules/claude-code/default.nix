{ pkgs, ... }:
{
  home.packages = [
    pkgs.claude-code
    pkgs.rtk
  ];

  home.file.".claude/hooks/rtk-rewrite.sh" = {
    source = ./hooks/rtk-rewrite.sh;
    executable = true;
  };
}
