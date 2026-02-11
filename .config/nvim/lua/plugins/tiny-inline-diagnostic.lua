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
}
