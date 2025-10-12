{ pkgs, config, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      source ${./config.fish}
    '';
  };
}
