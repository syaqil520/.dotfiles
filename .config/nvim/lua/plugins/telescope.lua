return {
  {
    "telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    keys = {
      {
        "<Leader>ds",
        function()
          require("telescope.builtin").lsp_document_symbols()
        end,
        desc = "[D]ocument [S]ymbol",
      },
      {
        "<Leader>ws",
        function()
          require("telescope.builtin").lsp_workspace_symbols()
        end,
        desc = "[W]orkspace [S]ymbol",
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")

      opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
        wrap_results = true,
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
        mappings = {
          n = {},
        },
        file_ignore_patterns = {
          "node_modules",
        },
      })
      opts.pickers = {
        diagnostics = {
          theme = "ivy",
          initial_mode = "normal",
          layout_config = {
            preview_cutoff = 9999,
          },
        },
      }
      telescope.setup(opts)
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("flutter")
    end,
  },
}
