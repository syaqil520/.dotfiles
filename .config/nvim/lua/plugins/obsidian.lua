local prefix = "<leader>o"
return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  enabled = false,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  event = {
    "BufReadPre " .. vim.fn.expand("~") .. "obsidian/**/*.md",
    "BufNewFile " .. vim.fn.expand("~") .. "obsidian/**/*.md",
  },
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
}
