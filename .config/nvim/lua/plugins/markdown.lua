local prefix = "<leader>o"
return {
  {
    "brianhuster/live-preview.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    -- dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" }, -- if you use standalone mini plugins
    opts = {
      heading = {
        position = "inline",
        border = true,
      },
      code = {
        width = "block",
        min_width = 45,
        left_pad = 2,
        language_pad = 2,
        position = "right",
      },
      completions = {
        lsp = {
          enabled = false,
        },
      },
      checkbox = {
        unchecked = {
          icon = "[ ]",
        },
        checked = {
          icon = "[X]",
        },
        custom = {
          todo = { rendered = "[-]" },
        },
      },
    },
    ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
    config = function(_, opts)
      require("render-markdown").setup(opts)
      Snacks.toggle({
        name = "Render Markdown",
        get = require("render-markdown").get,
        set = require("render-markdown").set,
      }):map("<leader>um")
    end,
  },
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   "BufReadPre " .. vim.fn.expand("~") .. "obsidian/**/*.md",
    --   "BufNewFile " .. vim.fn.expand("~") .. "obsidian/**/*.md",
    -- },
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/obsidian/personal",
        },
        {
          name = "work",
          path = "~/obsidian/work",
        },
      },
      ui = {
        enable = false,
      },
      legacy_commands = false,

      completion = {
        blink = true,
        nvim_cmp = false,
        min_chars = 2,
      },
    },
    keys = {
      { prefix .. "g", "<cmd>Obsidian search<CR>", desc = "Grep" },
      { prefix .. "n", "<cmd>Obsidian new<CR>", desc = "New Note" },
      { prefix .. "N", "<cmd>Obsidian new_from_template<CR>", desc = "New Note (Template)" },
      { prefix .. "<space>", "<cmd>Obsidian quick_switch<CR>", desc = "Find Files" },
      { prefix .. "b", "<cmd>Obsidian backlinks<CR>", desc = "Backlinks" },
      { prefix .. "t", "<cmd>Obsidian tags<CR>", desc = "Tags" },
      { prefix .. "T", "<cmd>Obsidian template<CR>", desc = "Template" },
      { prefix .. "L", "<cmd>Obsidian link<CR>", mode = "v", desc = "Link" },
      { prefix .. "l", "<cmd>Obsidian links<CR>", desc = "Links" },
      { prefix .. "l", "<cmd>Obsidian link_new<CR>", mode = "v", desc = "New Link" },
      { prefix .. "e", "<cmd>Obsidian extract_note<CR>", mode = "v", desc = "Extract Note" },
      { prefix .. "w", "<cmd>Obsidian workspace<CR>", desc = "Workspace" },
      { prefix .. "r", "<cmd>Obsidian rename<CR>", desc = "Rename" },
      { prefix .. "i", "<cmd>Obsidian paste_img<CR>", desc = "Paste Image" },
      {
        prefix .. "c",
        function()
          return require("obsidian").util.toggle_checkbox()
        end,
        desc = "Smart action",
      },
      {
        "<cr>",
        function()
          return require("obsidian").util.smart_action()
        end,
        desc = "Smart action",
      },
    },
  },
}
