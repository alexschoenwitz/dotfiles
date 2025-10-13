{ pkgs, ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        extraOptions = {
          UseKeychain = "yes";
          AddKeysToAgent = "yes";
          IdentityFile = "~/.ssh/id_rsa";
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
        "if ! /usr/bin/ssh-add -l | grep -q 'id_rsa'; then /usr/bin/ssh-add --apple-use-keychain /Users/alexandre.schoenwitz/.ssh/id_rsa; fi"
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

