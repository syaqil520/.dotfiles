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
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            bigfile = { enabled = true },
            dashboard = { enabled = false },
            explorer = { enabled = false },
            image = { enabled = false },
            indent = {
                enabled = false,
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
                            -- ["<Esc>"] = { "close", mode = { "n", "i" } },
                            ["<a-f>"] = {},
                            ["<a-h>"] = {},
                            ["<a-.>"] = { "toggle_hidden", mode = { "i", "n" } },
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
            scope = { enabled = false },
            scroll = { enabled = false },
            statuscolumn = { enabled = true },
            words = { enabled = true },
            toggle = { enabled = true },
        },
    -- stylua: ignore
    keys = {
      { "<leader><leader>", function() Snacks.picker.files({ hidden = true, ignored = false }) end, desc = "Find Files" },
      { "<leader>fw", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>f:", function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>fn", function() Snacks.picker.notifications() end, desc = "Notification History" },
      { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
      { "<leader>fR", function() Snacks.picker.resume() end, desc = "Resume" },
      { '<leader>f"', function() Snacks.picker.registers() end, desc = "Registers" },
      -- git
      { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
      { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
      { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
      { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
      { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
      { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
      { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
      -- Grep
      { "<leader>fc", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
      -- { "<leader>e", function() Snacks.explorer({ auto_close = true }) end, desc = "File Explorer" },
      -- Search
      { "<leader>fh", function() Snacks.picker.search_history() end, desc = "Search History" },
      { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      { "<leader>fD", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
      { "<leader>fd", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
      { "<leader>fq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
      { "<leader>fu", function() Snacks.picker.undo() end, desc = "Undo History" },
      { "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
      { "<leader>ft", function() Snacks.picker.todo_comments() end, desc = "Todo" },
      { "<leader>fT", function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" }
  },
    },
}
