return {
  -- debugger
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
    },
    event = "VeryLazy",
    config = function()
      require("dapui").setup({
        icons = { expanded = "▾", collapsed = "▸" },
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              "breakpoints",
              "stacks",
              "watches",
            },
            size = 10, -- columns
            position = "bottom",
          },
        },
      })
    end,
  },
  -- flutter
  {
    "akinsho/flutter-tools.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    config = function()
      local dartExcludedFolders = {
        vim.fn.expand("$HOME/AppData/Local/Pub/Cache"),
        vim.fn.expand("$HOME/.pub-cache"),
        -- vim.fn.expand("/opt/homebrew/"),
        vim.fn.expand("$HOME/tools/flutter/"),
      }

      require("flutter-tools").setup({
        flutter_path = "/usr/bin/flutter",
        flutter_lookup_cmd = nil,
        fvm = false,
        widget_guides = { enabled = true },
        lsp = {
          -- on_attach = function ()
          --   local lsp = require("neovim/nvim-lspconfig")
          -- end,
          color = {
            enabled = true,
            background = true,
            virtual_text = false,
          },
          settings = {
            showtodos = true,
            completefunctioncalls = true,
            analysisexcludedfolders = dartExcludedFolders,
            renamefileswithclasses = "prompt",
            updateimportsonrename = true,
            enablesnippets = false,
          },
        },
        debugger = {
          enabled = true,
          run_via_dap = true,
          exception_breakpoints = {},
          register_configurations = function(paths)
            local dap = require("dap")
            -- See also: https://github.com/akinsho/flutter-tools.nvim/pull/292
            dap.adapters.dart = {
              type = "executable",
              command = paths.flutter_bin,
              args = { "debug-adapter" },
            }
            dap.configurations.dart = {}
            require("dap.ext.vscode").load_launchjs()
          end,
        },
        decorations = {
          statusline = {
            device = true,
            project_config = true,
          },
        },
      })
    end,
  },
  -- for dart syntax hightling
  {
    "dart-lang/dart-vim-plugin",
  },
  {
    "robertbrunhage/dart-tools.nvim",
  },
  {
    "SirVer/Ultisnips",
  },
  {
    "honza/vim-snippets",
  },
  {
    "natebosch/dartlang-snippets",
  },
}
