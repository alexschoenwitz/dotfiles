{ config, ... }: {
  xdg.configFile."kitty/config" = {
    source = config.lib.file.mkOutOfStoreSymlink ./config;
  };
}
