{
  lsp.servers.rust_analyzer = {
    enable = true;
    installCargo = true;
    installRustc = true;
  };
  conform-nvim.settings.formatters_by_ft.rust = [ "rustfmt" ];
}
