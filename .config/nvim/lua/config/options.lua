-- UI
vim.wo.number = true -- Make line numbers default (default: false)
vim.o.relativenumber = true -- Set relative numbered lines (default: false)
vim.opt.pumblend = 10 -- Popup blend
vim.opt.inccommand = "nosplit" -- preview incremental substitute
vim.opt.termguicolors = true -- Set termguicolors to enable highlight groups (default: false)
vim.wo.signcolumn = "yes:2" -- Keep signcolumn on by default (default: 'auto')
vim.o.winborder = "rounded" -- or 'single', 'double'
vim.o.cursorline = true -- Highlight the current line (default: false)
vim.o.hlsearch = true -- Set highlight on search (default: true)
vim.o.numberwidth = 4 -- Set number column width to 2 {default 4} (default: 4)
vim.opt.shortmess:append("c") -- Don't give |ins-completion-menu| messages (default: does not include 'c')

-- General
vim.o.mouse = "a" -- Enable mouse mode (default: '')
vim.o.spell = false
vim.o.wrap = true -- Display lines as one long line (default: true)
vim.o.linebreak = false -- Companion to wrap, don't split words (default: false)
vim.o.conceallevel = 0 -- So that `` is visible in markdown files (default: 1)
vim.o.updatetime = 250 -- Decrease update time (default: 4000)
vim.o.timeoutlen = 300 -- Time to wait for a mapped sequence to complete (in milliseconds) (default: 1000)
vim.o.cmdheight = 1 -- More space in the Neovim command line for displaying messages (default: 1)
vim.opt.confirm = true -- Confirm to save changes before exiting modified buffer
vim.o.undofile = true -- Save undo history (default: false)
vim.opt.formatoptions:remove({ "c", "r", "o" }) -- Don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode. (default: 'croql')
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.wildmode = "longest:full,full" -- Command-line completion mode
vim.g.autoformat = true

-- Backup
vim.o.backup = false -- Creates a backup file (default: false)
vim.o.writebackup = false -- If a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited (default: true)
vim.o.swapfile = false -- Creates a swapfile (default: true)

-- Layout
vim.o.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor (default: 0)
vim.o.sidescrolloff = 8 -- Minimal number of screen columns either side of cursor if wrap is `false` (default: 0)
vim.o.splitbelow = true -- Force all horizontal splits to go below current window (default: false)
vim.o.splitright = true -- Force all vertical splits to go to the right of current window (default: false)
vim.o.pumheight = 10 -- Pop up menu height (default: 0)
vim.o.showmode = false -- We don't need to see things like -- INSERT -- anymore (default: true)
vim.o.showtabline = 2 -- Always show tabs (default: 1)
vim.opt.winminwidth = 5 -- Minimum window width

-- Edit
vim.o.completeopt = "menu,menuone,noselect" -- Set completeopt to have a better completion experience (default: 'menu,preview')
vim.opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
vim.o.smartcase = true -- Smart case (default: false)
vim.o.ignorecase = true -- Case-insensitive searching UNLESS \C or capital in search (default: false)
vim.o.clipboard = "unnamedplus" -- Sync clipboard between OS and Neovim. (default: '')
vim.opt.iskeyword:append("-") -- Hyphenated words recognized by searches (default: does not include '-')
vim.o.autoindent = true -- Copy indent from current line when starting new one (default: true)
vim.o.whichwrap = "bs<>[]hl" -- Which "horizontal" keys are allowed to travel to prev/next line (default: 'b,s')

-- Fold
vim.opt.foldlevel = 99

-- Tabspace
vim.o.shiftwidth = 4 -- The number of spaces inserted for each indentation (default: 8)
vim.o.tabstop = 4 -- Insert n spaces for a tab (default: 8)
vim.o.softtabstop = 4 -- Number of spaces that a tab counts for while performing editing operations (default: 0)
vim.o.expandtab = true -- Convert tabs to spaces (default: false)
vim.o.breakindent = true -- Enable break indent (default: false)
vim.o.smartindent = true -- Make indenting smarter again (default: false)
vim.o.smarttab = true

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- disable snack animation
vim.g.snacks_animate = false

-- Enable undercurl support (works with both tmux-256color and xterm-256color)
vim.cmd([[
  let &t_Cs = "\e[4:3m"
  let &t_Ce = "\e[4:0m"
]])
