return {
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    dependencies = { "nvim-mini/mini.icons" },
    config = function()
      vim.keymap.set("n", "<leader>e", function()
        require("oil").toggle_float()
      end, { desc = "Open Oil editor" })

      -- snacks rename
      vim.api.nvim_create_autocmd("User", {
        pattern = "OilActionsPost",
        callback = function(event)
          if event.data.actions[1].type == "move" then
            Snacks.rename.on_rename_file(event.data.actions[1].src_url, event.data.actions[1].dest_url)
          end
        end,
      })

      local oil = require("oil")
      local details = true
      oil.setup({
        default_file_explorer = true,
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
        view_options = {
          show_hidden = true,
        },
        constrain_cursor = "name",
        -- columns = {
        --   "permissions",
        --   "size",
        --   "mtime",
        --   "icon",
        -- },
        win_options = {
          signcolumn = "yes:2",
        },
        keymaps = {
          ["<bs>"] = { "actions.parent", mode = "n" },
          ["gd"] = {
            desc = "Toggle detail view",
            callback = function()
              details = not details
              if details then
                oil.set_columns({ "permissions", "size", "mtime", "icon" })
              else
                oil.set_columns({ "icon" })
              end
            end,
          },
        },
      })
    end,
  },
  {
    "refractalize/oil-git-status.nvim",
    dependencies = { "stevearc/oil.nvim" },
    opts = {},
  },
}
