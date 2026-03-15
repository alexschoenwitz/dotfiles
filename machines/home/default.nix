{ pkgs, user, ... }:
{
  imports = [ ../shared/darwin.nix ];

  homebrew.casks = [
    "brave-browser"
  ];

  home-manager.users.${user.username} = {
    imports = [ ../../modules/default-user.nix ];
    home.sessionVariables.SSH_KEY_PATH = "~/.ssh/id_ed25519";
    programs.git.settings.user.email = "alexandre.schoenwitz@gmail.com";
    programs.git.signing.key = "~/.ssh/id_ed25519.pub";
    programs.jujutsu.settings.user.email = "alexandre.schoenwitz@gmail.com";
    programs.jujutsu.settings.signing.key = "~/.ssh/id_ed25519.pub";
    home.packages = [ pkgs.claude-code ];
  };
}
