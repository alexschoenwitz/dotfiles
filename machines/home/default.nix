{ user, ... }:
{
  imports = [ ../shared/darwin.nix ];

  home-manager.users.${user.username} = {
    imports = [ ../../modules/default-user.nix ];
    home.sessionVariables = {
      SSH_KEY_PATH = "~/.ssh/id_ed25519";
    };
    programs.git.settings.user.email = "alexandre.schoenwitz@gmail.com";
    programs.git.signing.key = "~/.ssh/id_ed25519.pub";
  };
}
