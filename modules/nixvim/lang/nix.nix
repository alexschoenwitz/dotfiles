{
  lsp = {
    servers = {
      nixd.enable = true;
    };
  };
  conform-nvim = {
    settings = {
      formatters_by_ft = {
        nix = [ "nixfmt" ];
      };
    };
  };
}
