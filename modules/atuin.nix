{ ... }:
{
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    flags = [ "--disable-up-arrow" ];
    settings = {
      dialect = "uk";
      filter_mode_shell_up_arrow = "session";
      style = "compact";
      show_help = false;
    };
  };
}
