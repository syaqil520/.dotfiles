-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local del = vim.keymap.del
local opts = { noremap = true, silent = true }

-- delete unused mapping
del("n", "<A-j>")
del("n", "<A-k>")
del("n", "[b")
del("n", "]b")
del("n", "<leader>bb")
del("n", "<leader>`")
-- del("n", "<leader>bo")
del("n", "<leader>bD")
del("n", "<leader>K")
del("n", "<leader>l")
del("n", "<leader>us")
del("n", "<leader>uL")
del("n", "<leader>ul")
del("n", "<leader>uc")
del("n", "<leader>ur")
del("n", "<leader>uT")
del("n", "<leader>ub")
del("n", "<leader>qq")
del("n", "<leader>ui")
del("n", "<leader>uI")
del("n", "<leader>L")
del("n", "<leader>ft")
del("n", "<leader>fT")
del("n", "<leader><tab>l")
del("n", "<leader><tab>o")
del("n", "<leader><tab>f")
del("n", "<leader><tab><tab>")
del("n", "<leader><tab>[")
del("n", "<leader><tab>d")
del("n", "<leader><tab>]")
del("n", "<leader>fn")

-- Do things without affecting the registers
map("n", "x", '"_x')
map("n", "<Leader>p", '"0p')
map("n", "<Leader>P", '"0P')
map("v", "<Leader>p", '"0p')
map("n", "-c", '"_c')
map("n", "-C", '"_C')
map("v", "-c", '"_c')
map("v", "-C", '"_C')
map("n", "-d", '"_d')
map("n", "-D", '"_D')

map("n", "<C-a>", "ggVG", { desc = "Select all" })

-- center when moving up and down
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- center when go end of line
map("n", "G", "Gzz")

-- Move Lines
map("v", "J", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "K", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- Split window
map("n", "ss", ":split<Return>", opts)
map("n", "sv", ":vsplit<Return>", opts)

-- improve nav in insert mode
map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

-- nvchad
-- map('n', '<leader>ct', function()
--   require('nvchad.themes').open()
-- end, { desc = 'telescope nvchad themes' })
-- map('n', '<leader>ch', '<cmd>NvCheatsheet<CR>', { desc = 'toggle nvcheatsheet' })
