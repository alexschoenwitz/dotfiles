# Darwin-specific user modules
{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf pkgs.stdenv.isDarwin {
    home.file.".aerospace.toml".source = ./aerospace/aerospace.toml;

    launchd.agents.colima = {
      enable = true;
      config = {
        ProgramArguments = [
          "${pkgs.colima}/bin/colima"
          "start"
          "--foreground"
          "--cpu"
          "4"
          "--memory"
          "8"
          "--disk"
          "60"
          "--vm-type"
          "vz"
          "--mount-type"
          "virtiofs"
        ];
        RunAtLoad = true;
        KeepAlive = true;
      };
    };

    launchd.agents.docker-cleanup = {
      enable = true;
      config = {
        ProgramArguments = [
          "${pkgs.writeShellScript "docker-cleanup" ''
            export DOCKER_HOST="unix://${config.home.homeDirectory}/.colima/default/docker.sock"
            ${pkgs.docker}/bin/docker system prune -af --volumes --filter "until=720h"
          ''}"
        ];
        StartCalendarInterval = [
          {
            Weekday = 0;
            Hour = 2;
            Minute = 0;
          }
        ];
      };
    };

  };
}
