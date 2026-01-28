{ config, ... }:
{
  xdg.configFile."aerospace/aerospace.toml" = {
    source = config.lib.file.mkOutOfStoreSymlink ./aerospace.toml;
  };

  launchd.agents.aerospace = {
    enable = true;
    config = {
      ProgramArguments = [ "${config.home.homeDirectory}/.nix-profile/Applications/AeroSpace.app/Contents/MacOS/AeroSpace" ];
      RunAtLoad = true;
      KeepAlive = false;
    };
  };
}
