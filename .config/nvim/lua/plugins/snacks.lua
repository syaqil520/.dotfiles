return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          Snacks.toggle.diagnostics():map("<leader>ud")
          Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
          Snacks.toggle.treesitter():map("<leader>uT")
          Snacks.toggle.inlay_hints():map("<leader>uh")
          Snacks.toggle.indent():map("<leader>ug")
        end,
      })
    end,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = {
        sections = {
          { section = "header" },
          { section = "keys", gap = 1 },
          { section = "startup" },
        },
      },
      explorer = {
        enabled = true,
        trash = true,
      },
      image = { enabled = true },
      indent = {
        enabled = true,
        only_current = true, -- only show indent guides in the current window
      },
      input = { enabled = true },
      picker = {
        enabled = true,
        matcher = {
          sort_empty = true,
          frecency = true,
          history_bonus = true,
        },
        win = {
          input = {
            keys = {
              -- to close the picker on ESC instead of going to normal mode,
              -- add the following keymap to your config
              ["<Esc>"] = { "close", mode = { "n", "i" } },
              ["<c-b>"] = { "close", mode = { "n" } },
              ["<a-BS>"] = { "<c-s-w>", mode = { "i" }, expr = true, desc = "delete word" },
              ["<a-f>"] = {},
              ["<a-h>"] = {},
              ["<a-.>"] = { "toggle_hidden", mode = { "i", "n" } },
            },
          },
          list = {
            keys = {
              ["<c-b>"] = { "close", mode = "n" },
            },
          },
        },
        exclude = {
          ".git",
          "node_modules",
        },
      },
      notifier = { enabled = true, timeout = 2500 },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = false },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      toggle = { enabled = true },
      terminal = { win = { position = "float" } },
    },
    -- stylua: ignore
    keys = {
      { "<leader><leader>", function() Snacks.picker.files({ hidden = false, ignored = false }) end,                desc = "Find Files" },
      { "<leader>fw",       function() Snacks.picker.grep() end,                                                   desc = "Grep" },
      { "<leader>f:",       function() Snacks.picker.command_history() end,                                        desc = "Command History" },
      { "<leader>fc",       function() Snacks.picker.commands() end,                                        desc = " Find Command" },
      { "<leader>fn",       function() Snacks.picker.notifications() end,                                          desc = "Notification History" },
      { "<leader>fr",       function() Snacks.picker.recent() end,                                                 desc = "Recent" },
      { "<leader>fR",       function() Snacks.picker.resume() end,                                                 desc = "Resume" },
      { '<leader>f"',       function() Snacks.picker.registers()  end,                                              desc = "Registers"},
      { "<leader>fb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      -- explorer
      { "<c-e>", function() Snacks.explorer() end, desc = "File Explorer" },
      -- git
      { "<leader>gs",       function() Snacks.picker.git_status() end,                                             desc = "Git Status" },
      { "<leader>gd",       function() Snacks.picker.git_diff() end,                                               desc = "Git Diff (Hunks)" },
      { "<leader>gf",       function() Snacks.picker.git_log_file() end,                                           desc = "Git Current File History" },
      { "<leader>gB",        function() Snacks.gitbrowse() end, desc = "Git Browse (open)" , mode = { "n", "x" }},
      { "<leader>gb", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
      -- Grep
      { "<leader>fs",       function() Snacks.picker.grep_word() end,                                              desc = "Visual selection or word", mode = { "n", "x" } },
      -- Search
      { "<leader>fh",       function() Snacks.picker.search_history() end,                                         desc = "Search History" },
      { "<leader>fk",       function() Snacks.picker.keymaps() end,                                                desc = "Keymaps" },
      { "<leader>fD",       function() Snacks.picker.diagnostics() end,                                            desc = "Diagnostics" },
      { "<leader>fd",       function() Snacks.picker.diagnostics_buffer() end,                                     desc = "Buffer Diagnostics" },
      { "<leader>fq",       function() Snacks.picker.qflist() end,                                                 desc = "Quickfix List" },
      { "<leader>fu",       function() Snacks.picker.undo() end,                                                   desc = "Undo History" },
      { "<leader>ft",       function() Snacks.picker.todo_comments() end,                                          desc = "Todo" },
      { "<leader>fT",       function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" }
    },
  },
}
