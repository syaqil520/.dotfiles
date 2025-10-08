return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "j-hui/fidget.nvim", opts = {} },
    },
  },
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    opts = {},
    config = function()
      local lspserver = require("config.lspserver")
      require("mason").setup()

      local servers = vim.tbl_keys(lspserver.servers or {})
      local ensure_installed = vim.list_extend(servers, lspserver.other or {})

      require("mason-tool-installer").setup({
        ensure_installed = ensure_installed,
      })
      require("mason-lspconfig").setup({
        automatic_enable = true,
        ensure_installed = {}, -- installed with mason-tool-installer
      })
    end,
  },
}
