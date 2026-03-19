{ pkgs, user, ... }:
{
  home.username = user.username;
  home.stateVersion = "24.11";
  home.homeDirectory =
    if pkgs.stdenv.isDarwin then "/Users/${user.username}" else "/home/${user.username}";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.nix-index.enable = true;

  home.sessionVariables = {
    LC_ALL = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    PROJECTS = "$HOME/Projects";
    EDITOR = "nvim";
  };

  # ensures ~/Projects folder exists.
  # this folder is later assumed by other activations, specially on darwin.
  home.activation.developer = ''
    mkdir -p ~/Projects
  '';
}
