local util = require("lspconfig.util")

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
      inlay_hints = {
        enabled = false,
        exclude = { "dart" },
      },
      servers = {

        -- volar = {
        --   filetypes = {
        --     "typescript",
        --     "vue",
        --   },
        --   root_dir = util.root_pattern("src/App.vue"),
        -- },

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

        -- sourcekit = {
        --   capabilities = {
        --     workspace = {
        --       didChangeWatchedFiles = {
        --         dynamicRegistration = true,
        --       },
        --     },
        --   },
        --   keys = {},
        --   cmd = {
        --     vim.trim(vim.fn.system("xcrun -f sourcekit-lsp")),
        --   },
        --   filetypes = { "swift", "c", "cpp", "objective-c", "objective-cpp" },
        --   root_dir = function(filename, _)
        --     return util.root_pattern("buildServer.json")(filename)
        --       or util.root_pattern("*.xcodeproj", "*.xcworkspace")(filename)
        --       or util.root_pattern("Package.swift")(filename)
        --       or util.find_git_ancestor(filename)
        --   end,
        -- },
      },
    },
  },
}
