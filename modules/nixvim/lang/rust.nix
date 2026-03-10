{
  lsp.servers.rust_analyzer = {
    enable = true;
    installCargo = false;
    installRustc = false;
  };
  conform-nvim.settings.formatters_by_ft.rust = [ "rustfmt" ];
}
