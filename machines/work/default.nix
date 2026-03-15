{ pkgs, user, ... }:
{
  imports = [ ../shared/darwin.nix ];

  homebrew.casks = [
    "brave-browser"
    "visual-studio-code"
  ];

  home-manager.users.${user.username} = {
    imports = [ ../../modules/default-user.nix ];
    home.sessionVariables.SSH_KEY_PATH = "~/.ssh/id_rsa";
    programs.git.settings.user.email = "alexandre.schoenwitz@freiheit.com";
    programs.git.signing.key = "~/.ssh/id_rsa.pub";
    programs.jujutsu.settings.user.email = "alexandre.schoenwitz@freiheit.com";
    programs.jujutsu.settings.signing.key = "~/.ssh/id_rsa.pub";
    home.packages = [
      pkgs.github-copilot-cli
      pkgs.claude-code
    ];
  };
}
