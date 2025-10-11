{
  lsp = {
    servers = {
      html.enable = true;
    };
  };
  conform-nvim = {
    settings = {
      formatters_by_ft = {
        html = [ "prettierd" ];
        css = [ "prettierd" ];
      };
    };
  };
}
