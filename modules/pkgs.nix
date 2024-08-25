{ pkgs, lib, ... }: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
  home.packages = with pkgs; with pkgs.nodePackages_latest; [
    curl
    jq
    nmap
    ripgrep
    sqlite
    wget

    kubectl

    # treesitter, lsps, formatters, etc
    bash-language-server
    gofumpt
    nil # nix lsp
    nixpkgs-fmt
    prettier
    shellcheck
    shfmt
    sql-formatter
    stylua
    sumneko-lua-language-server
    terraform-ls
    tree-sitter
    yaml-language-server
    yamllint
  ] ++ (lib.optionals pkgs.stdenv.isDarwin [
    terminal-notifier
  ]);
}
