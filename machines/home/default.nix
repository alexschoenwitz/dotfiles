{ pkgs, user, ... }:
{
  imports = [ ../shared/darwin.nix ];

  homebrew.casks = [
    "brave-browser"
    "visual-studio-code"
  ];

  home-manager.users.${user.username} = {
    imports = [ ../../modules/default-user.nix ];
    home.sessionVariables.SSH_KEY_PATH = "~/.ssh/id_ed25519";
    programs.git.userEmail = "alexandre.schoenwitz@gmail.com";
    programs.git.extraConfig.user.signingKey = "~/.ssh/id_ed25519";
    home.packages = [ pkgs.claude-code ];
  };
}
