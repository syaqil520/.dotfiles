return {
  {
    "telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "nvim-telescope/telescope-frecency.nvim",
    },
    keys = function()
      return {
        { "<leader><space>", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
        { "<leader>f:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
        {
          "<leader>fb",
          "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
          desc = "Switch Buffer",
        },
        { "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
        { "<leader>fC", "<cmd>Telescope commands<cr>", desc = "Commands" },
        { "<leader>fd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
        { "<leader>fD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
        { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
        { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Files (git-files)" },
        { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
        { "<leader>fR", "<cmd>Telescope resume<cr>", desc = "Resume" },
        { "<leader>fq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix List" },
        { "<leader>fw", LazyVim.pick("live_grep"), desc = "Word (Root Dir)" },
        { "<leader>fW", LazyVim.pick("live_grep", { root = false }), desc = "Word (cwd)" },
        { "<leader>fw", LazyVim.pick("grep_string"), mode = "v", desc = "Selection (Root Dir)" },
        {
          "<leader>fs",
          function()
            require("telescope.builtin").lsp_document_symbols({
              symbols = LazyVim.config.get_kind_filter(),
            })
          end,
          desc = "Goto Symbol",
        },
        {
          "<leader>fS",
          function()
            require("telescope.builtin").lsp_dynamic_workspace_symbols({
              symbols = LazyVim.config.get_kind_filter(),
            })
          end,
          desc = "Goto Symbol (Workspace)",
        },
        -- git
        { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
        { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Status" },
      }
    end,
    opts = {
      defaults = {
        prompt_prefix = "   ",
        selection_caret = " ",
        entry_prefix = " ",
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
          width = 0.87,
          height = 0.80,
        },
        wrap_results = true,
        layout_strategy = "horizontal",
        winblend = 0,
        mappings = {
          n = { ["q"] = require("telescope.actions").close },
          i = { ["<c-enter>"] = "to_fuzzy_refine" },
        },
        file_ignore_patterns = {
          "node_modules",
        },
      },
      pickers = {
        diagnostics = {
          theme = "ivy",
          initial_mode = "normal",
          layout_config = {
            preview_cutoff = 9999,
          },
        },
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
      require("telescope").load_extension("frecency")
    end,
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    opts = {},
  },
}
