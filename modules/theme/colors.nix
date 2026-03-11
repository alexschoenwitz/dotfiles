{ lib, config, nix-colors, ... }:
{
  options.theme.palette = lib.mkOption {
    type = lib.types.attrsOf lib.types.str;
  };

  options.theme.paletteHash = lib.mkOption {
    type = lib.types.attrsOf lib.types.str;
  };

  config.theme = {
    palette = nix-colors.colorSchemes.gruvbox-dark-medium.palette;
    paletteHash = lib.mapAttrs (_: v: "#${v}") config.theme.palette;
  };
}
