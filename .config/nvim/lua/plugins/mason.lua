return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        automatic_enable = true,
      })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    cmd = "Mason",
    config = function()
      local lspserver = require("utils.lspserver")
      local servers = vim.tbl_keys(lspserver.servers or {})
      local ensure_installed = vim.list_extend(servers, lspserver.other or {})

      require("mason-tool-installer").setup({
        ensure_installed = ensure_installed,
      })
    end,
  },
}
