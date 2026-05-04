{
  lib,
  config,
  nix-colors,
  ...
}:
{
  options.theme = {
    dark = {
      palette = lib.mkOption { type = lib.types.attrsOf lib.types.str; };
      paletteHash = lib.mkOption { type = lib.types.attrsOf lib.types.str; };
    };
    light = {
      palette = lib.mkOption { type = lib.types.attrsOf lib.types.str; };
      paletteHash = lib.mkOption { type = lib.types.attrsOf lib.types.str; };
    };
  };

  config.theme = {
    dark = {
      palette = nix-colors.colorSchemes.gruvbox-dark-medium.palette;
      paletteHash = lib.mapAttrs (_: v: "#${v}") config.theme.dark.palette;
    };
    light = {
      palette = nix-colors.colorSchemes.gruvbox-light-medium.palette;
      paletteHash = lib.mapAttrs (_: v: "#${v}") config.theme.light.palette;
    };
  };
}
