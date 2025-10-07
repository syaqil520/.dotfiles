return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    enabled = true,
    config = function()
      vim.diagnostic.config({ virtual_text = false })
      -- Default configuration
      require("tiny-inline-diagnostic").setup({
        preset = "ghost",
        options = {
          -- If multiple diagnostics are under the cursor, display all of them.
          multiple_diag_under_cursor = true,
          multilines = true,
          show_source = {
            enabled = false,
            if_many = false,
          },
        },
      })
    end,
  },
  {
    "nmac427/guess-indent.nvim",
    opts = {
      auto_cmd = true, -- Set to false to disable automatic execution
      override_editorconfig = false, -- Set to true to override settings set by .editorconfig
      filetype_exclude = { -- A list of filetypes for which the auto command gets disabled
        "netrw",
        "tutor",
      },
      buftype_exclude = { -- A list of buffer types for which the auto command gets disabled
        "help",
        "nofile",
        "terminal",
        "prompt",
      },
      on_tab_options = { -- A table of vim options when tabs are detected
        ["expandtab"] = false,
      },
      on_space_options = { -- A table of vim options when spaces are detected
        ["expandtab"] = true,
        ["tabstop"] = "detected", -- If the option value is 'detected', The value is set to the automatically detected indent size.
        ["softtabstop"] = "detected",
        ["shiftwidth"] = "detected",
      },
    },
  },
  {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
        "folke/snacks.nvim",
        opts = {
          terminal = {},
        },
      },
    },
    event = "LspAttach",
    opts = {},
    keys = {
      {
        "<leader>ca",
        function()
          require("tiny-code-action").code_action()
        end,
        { desc = "Code Action", noremap = true, silent = true },
      },
    },
  },
}
