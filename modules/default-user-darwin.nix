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
        ];
        RunAtLoad = true;
        KeepAlive = false;
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

    home.activation.colima-config = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p ~/.colima/default
      cat > ~/.colima/default/colima.yaml << 'EOF'
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
      EOF
    '';
  };
}
