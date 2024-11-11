return {
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = {
      filters = { dotfiles = false },
      disable_netrw = true,
      hijack_cursor = true,
      sync_root_with_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = false,
      },
      view = {
        width = 35,
        preserve_window_proportions = true,
      },
      renderer = {
        root_folder_label = false,
        highlight_git = true,
        indent_markers = { enable = true },
        icons = {
          glyphs = {
            default = "󰈚",
            folder = {
              default = "",
              empty = "",
              empty_open = "",
              open = "",
              symlink = "",
            },
            git = { unmerged = "" },
          },
        },
      },
      actions = {
        open_file = {
          quit_on_open = true,
          window_picker = { enable = false },
        },
      },
      trash = {
        cmd = "trash-put",
      },
    },
    config = function(_, opts)
      local prev = { new_name = "", old_name = "" } -- Prevents duplicate events
      vim.api.nvim_create_autocmd("User", {
        pattern = "NvimTreeSetup",
        callback = function()
          local events = require("nvim-tree.api").events
          events.subscribe(events.Event.NodeRenamed, function(data)
            if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
              data = data
              Snacks.rename.on_rename_file(data.old_name, data.new_name)
            end
          end)
        end,
      })

      vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle nvim-tree" })
      require("nvim-tree").setup(opts)
    end,
  },
  {
    "otavioschwanck/arrow.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
    config = function()
      vim.keymap.set("n", "<tab>", require("arrow.persist").previous, { desc = "Move to next arrow persist" })
      vim.keymap.set("n", "<S-tab>", require("arrow.persist").next, { desc = "Move to previous arrow persist" })
      require("arrow").setup({

        show_icons = true,
        leader_key = "m", -- Recommended to be a single key
        buffer_leader_key = "M", -- Per Buffer Mappings
      })
    end,
  },
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    config = function()
      vim.keymap.set("n", "<leader>E", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
      require("oil").setup({
        default_file_explorer = false,
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
        view_options = {
          show_hidden = true,
        },
      })
    end,
  },
  {
    "folke/trouble.nvim",
    keys = {},
  },
}
