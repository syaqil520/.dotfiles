return {

  { "folke/flash.nvim", enabled = false },
  {
    "akinsho/bufferline.nvim",
    enabled = false,
    lazy = false,
    opts = {
      options = {
        underline_indicator = true,
        separator_style = "thick",
        show_buffer_close_icons = true,
        show_close_icon = false,
        diagnostic = "nvim_lsp",
        always_show_bufferline = true,
        middle_mouse_command = "bdelete! %d",
        indicator = {
          style = "underline",
        },
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    enabled = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        icons_enabled = true,
        theme = "onedark",
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        disabled_filetypes = {},
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          {
            "filename",
            file_status = true, -- displays file status (readonly status, modified status)
            path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
          },
        },
        lualine_x = {
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = " ", warn = " ", info = " ", hint = " " },
          },
          -- "encoding",
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            "filename",
            file_status = true, -- displays file status (readonly status, modified status)
            path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
          },
        },
        lualine_x = {
          "location",
        },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { "fugitive" },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_by_name = {
            ".git",
            ".DS_Store",
          },
          always_show_by_pattern = { -- uses glob style patterns
            ".env*",
          },
        },
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    enabled = false,
  },
  {
    "catpuccin/nvim",
    enabled = false,
  },
}
