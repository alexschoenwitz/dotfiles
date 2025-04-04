return {
  { "williamboman/mason-lspconfig.nvim", enabled = false },
  { "williamboman/mason.nvim", enabled = false },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nil_ls = {}, -- nix
        omnisharp = {}, -- c#
        gopls = {}, -- go
        rust_analyzer = {}, -- rust
        tsserver = {}, -- ts
        -- ts_ls = {}, -- ts
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        nix = { "nixfmt" }, -- nix
        csharp = { "csharpier" }, -- c#
        go = { "gofumpt", "goimports" }, -- go
        rust = { "rustfmt" }, -- rust
        typescript = { { "prettierd", "prettier" } },
        typescriptreact = { { "prettierd", "prettier" } },
        javascript = { { "prettierd", "prettier" } },
        javascriptreact = { { "prettierd", "prettier" } },
        json = { { "prettierd", "prettier" } },
        html = { { "prettierd", "prettier" } },
        css = { { "prettierd", "prettier" } },
      },
    },
  },
}
