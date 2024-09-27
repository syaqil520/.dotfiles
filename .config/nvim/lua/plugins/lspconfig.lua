local util = require("lspconfig.util")

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        -- exclude = { "dart" },
        enabled = false,
      },
      servers = {
        volar = {
          filetypes = {
            "typescript",
            "vue",
          },
          root_dir = util.root_pattern("src/App.vue"),
        },
        phpcs = {
          enabled = false,
        },
      },
    },
  },
}
