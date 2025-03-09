return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nil_ls = {},
        omnisharp = {},
        gopls = {},
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        nix = { "nixfmt" },
        csharp = { "csharpier" },
        go = { "gofumpt", "goimports" },
      },
    },
  },
}
