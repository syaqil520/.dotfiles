return {
  {
    "williamboman/mason.nvim",
    keys = {
      { "<leader>cm", false },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = false,
      },
      inlay_hints = {
        enabled = false,
        exclude = { "dart" },
      },
      servers = {

        vtsls = {
          settings = {
            typescript = {
              inlayHints = {
                enumMemberValues = { enabled = false },
                functionLikeReturnTypes = { enabled = false },
                parameterNames = { enabled = false },
                parameterTypes = { enabled = false },
                propertyDeclarationTypes = { enabled = false },
                variableTypes = { enabled = false },
              },
            },
          },
        },

        bashls = {
          filetypes = { "sh", "zsh" },
        },
      },
    },
  },
}
