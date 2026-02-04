return {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  lazy = false,
  config = function()
    vim.keymap.set("n", "<c-e>", "<cmd>NvimTreeToggle<cr>", { desc = "toggle nvim-tree" })
    local function custom_on_attach(bufnr)
      local api = require("nvim-tree.api")
      api.config.mappings.default_on_attach(bufnr)
      vim.keymap.del("n", "<c-e>", { buffer = bufnr })
    end
    local opts = {
      on_attach = custom_on_attach,
      filters = { dotfiles = false },
      hijack_cursor = true,
      sync_root_with_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = false,
      },
      view = {
        width = 50,
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
        -- WARNING: Mac = trash | Arch = trash-put (need to have trash-cli installed)
        cmd = "trash",
      },
    }
    require("nvim-tree").setup(opts)
  end,
}
