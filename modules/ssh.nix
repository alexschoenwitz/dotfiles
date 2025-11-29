{ config, lib, ... }:
let
  sshKeyPath = config.home.sessionVariables.SSH_KEY_PATH or "~/.ssh/id_rsa";
  sshKeyName = lib.last (lib.splitString "/" sshKeyPath);
  sshKeyFullPath = "${config.home.homeDirectory}/.ssh/${sshKeyName}";
in
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        extraOptions = {
          UseKeychain = "yes";
          AddKeysToAgent = "yes";
          IdentityFile = sshKeyPath;
        };
      };
    };
  };

  launchd.enable = true;

  launchd.agents.ssh-add-keychain = {
    enable = true;
    config = {
      RunAtLoad = true;

      Program = "/bin/bash";
      ProgramArguments = [
        "/bin/bash"
        "-c"
        "if ! /usr/bin/ssh-add -l | grep -q '${sshKeyName}'; then /usr/bin/ssh-add --apple-use-keychain ${sshKeyFullPath}; fi"
      ];

      StandardOutPath = "/dev/null";
      StandardErrorPath = "/dev/null";

      KeepAlive = false;

      EnvironmentVariables = {
        PATH = "/usr/bin:/bin";
      };
    };
  };
}

