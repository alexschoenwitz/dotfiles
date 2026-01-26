{ pkgs, config, ... }:
let
  dockerCleanup = pkgs.writeShellScript "docker-cleanup" ''
    export DOCKER_HOST="unix://${config.home.homeDirectory}/.colima/default/docker.sock"
    ${pkgs.docker}/bin/docker system prune -af --volumes --filter "until=720h"
  '';
in
{
  launchd.agents.colima = {
    enable = true;
    config = {
      ProgramArguments = [
        "${pkgs.colima}/bin/colima"
        "start"
        "--foreground"
      ];
      RunAtLoad = true;
      KeepAlive = false;
    };
  };

  launchd.agents.docker-cleanup = {
    enable = true;
    config = {
      ProgramArguments = [ "${dockerCleanup}" ];
      StartCalendarInterval = [
        {
          Weekday = 0;
          Hour = 2;
          Minute = 0;
        }
      ];
    };
  };

  home.file.".colima/default/colima.yaml".text = ''
    cpu: 4
    disk: 60
    memory: 8
    arch: aarch64
    runtime: docker

    kubernetes:
      enabled: false

    vmType: vz
    mountType: virtiofs

    docker: {}
  '';
}
