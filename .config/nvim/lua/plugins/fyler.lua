return {
  "A7Lavinraj/fyler.nvim",
  -- dependencies = { "nvim-mini/mini.icons" },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  branch = "stable", -- Use stable branch for production
  lazy = false, -- Necessary for `default_explorer` to work properly
  opts = {
    integrations = {
      icon = "nvim_web_devicons",
      winpick = "snacks",
    },
    views = {
      finder = {
        delete_to_trash = true,
        win = {
          kind = "split_left_most",
          kinds = {
            split_left_most = {
              width = "30%",
              win_opts = {
                winfixwidth = false,
              },
            },
          },
        },
      },
    },
  },
  config = function(_, opts)
    vim.keymap.set("n", "<c-e>", function()
      require("fyler").toggle()
    end, { desc = "Open Fyler tree view" })

    vim.keymap.set("n", "<leader>E", function()
      require("fyler").toggle({ kind = "float" })
    end, { desc = "Open Fyler tree view" })

    require("fyler").setup(opts)
  end,
}
