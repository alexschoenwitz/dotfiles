{
  lsp = {
    servers = {
      dartls.enable = true;
    };
  };
  conform-nvim = {
    settings = {
      formatters_by_ft = {
        dart = [ "dart_format" ];
      };
    };
  };
}
