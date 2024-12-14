-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options hereby

local opt = vim.opt
local g = vim.g

g.mapleader = " "

-- [[ Setting options ]]
opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.showmode = false

-- Indentaion
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.smartindent = true

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

opt.termguicolors = true
opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = "yes"
opt.updatetime = 250
opt.timeoutlen = 300
opt.splitright = true
opt.splitbelow = true
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.inccommand = "split"
opt.cursorline = true
opt.scrolloff = 10

opt.title = true
opt.hlsearch = true
opt.laststatus = 2
opt.linebreak = true
opt.inccommand = "split"
opt.wrap = true
opt.textwidth = 0

opt.backspace = { "start", "eol", "indent" }
opt.wildignore:append({ "*/node_modules/*" })

opt.backup = false
opt.backupskip = { "/tmp/*", "/private/tmp/*" }
opt.shell = "zsh"

opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

if vim.fn.has("wsl") == 1 then
  g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe",
    },
    paste = {
      ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end

-- Custom LazyVim option
g.lazyvim_php_lsp = "intelephense"
-- Set to false to disable auto format
-- vim.g.lazyvim_eslint_auto_format = true
vim.g.snacks_animate = false
