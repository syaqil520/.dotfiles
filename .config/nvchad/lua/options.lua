require "nvchad.options"

-- add yours here!

local o = vim.o
local g = vim.g
local opt = vim.opt
-- o.cursorlineopt ='both' -- to enable cursorline!

g.mapleader = " "

o.relativenumber = true
o.termguicolors = true

-- Indentaion
o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4
o.smartindent = true

o.number = true
o.relativenumber = true
o.title = true
o.hlsearch = true
o.scrolloff = 10
o.laststatus = 2
o.linebreak = true
o.inccommand = "split"
o.ignorecase = true
o.wrap = true
o.textwidth = 0

opt.backspace = { "start", "eol", "indent" }
opt.wildignore:append({ "*/node_modules/*" })

opt.backup = false
opt.backupskip = { "/tmp/*", "/private/tmp/*" }
opt.shell = "zsh"

opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
