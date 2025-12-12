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
    programs.git.settings.user.signingKey = "~/.ssh/id_rsa";
    home.packages = [
      pkgs.github-copilot-cli
      pkgs.claude-code
    ];
  };
}
