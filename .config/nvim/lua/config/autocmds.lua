-- Autocommand
local function augroup(name)
  return vim.api.nvim_create_augroup("qaizaa_" .. name, { clear = true })
end

local autocmd = function(events, group, ptn, cb)
  vim.api.nvim_create_autocmd(events, { pattern = ptn, group = augroup(group), [type(cb) == "function" and "callback" or "command"] = cb })
end

autocmd({ "FocusGained", "TermClose", "TermLeave" }, "checktime", nil, function()
  if vim.o.buftype ~= "nofile" then
    vim.cmd("checktime")
  end
end)

autocmd("TextYankPost", "highlight_yank", "*", function()
  vim.highlight.on_yank()
end)

autocmd("VimResized", "resize_splits", nil, function()
  local current_tab = vim.fn.tabpagenr()
  vim.cmd("tabdo wincmd =")
  vim.cmd("tabnext " .. current_tab)
end)

-- Restore last cursor position
autocmd("BufReadPost", "last_loc", nil, function(event)
  local exclude = { "gitcommit" }
  local buf = event.buf

  if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
    return
  end

  vim.b[buf].lazyvim_last_loc = true

  local mark = vim.api.nvim_buf_get_mark(buf, '"')
  local lcount = vim.api.nvim_buf_line_count(buf)

  if mark[1] > 0 and mark[1] <= lcount then
    pcall(vim.api.nvim_win_set_cursor, 0, mark)
  end
end)

-- Close special buffers with `q`
autocmd("FileType", "close_with_q", {
  "PlenaryTestPopup",
  "checkhealth",
  "dbout",
  "gitsigns-blame",
  "grug-far",
  "help",
  "lspinfo",
  "neotest-output",
  "neotest-output-panel",
  "neotest-summary",
  "notify",
  "qf",
  "spectre_panel",
  "startuptime",
  "tsplayground",
  "oil",
}, function(event)
  vim.bo[event.buf].buflisted = false

  vim.schedule(function()
    vim.keymap.set("n", "q", function()
      vim.cmd("close")
      pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
    end, {
      buffer = event.buf,
      silent = true,
      desc = "Quit buffer",
    })
  end)
end)

-- Make man buffers unlisted
autocmd("FileType", "man_unlisted", "man", function(event)
  vim.bo[event.buf].buflisted = false
end)

-- Fix conceallevel for JSON
autocmd("FileType", "json_conceal", { "json", "jsonc", "json5" }, function()
  vim.opt_local.conceallevel = 0
end)

-- Auto create directories on save
autocmd("BufWritePre", "auto_create_dir", nil, function(event)
  -- skip remote paths (scp://, etc)
  if event.match:match("^%w%w+:[\\/][\\/]") then
    return
  end

  local file = vim.uv.fs_realpath(event.match) or event.match
  vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
end)

-- Indentation rules → 2 spaces
autocmd("FileType", "indentation", {
  -- "html",
  -- "javascript",
  -- "typescript",
  -- "vue",
  -- "css",
  -- "scss",
  -- "dart",
  -- "typescript.tsx",
  -- "javascript.jsx",
  -- "javascriptreact",
  -- "typescriptreact",
  -- "dart",
  -- "json",
  "lua",
}, function()
  vim.opt_local.tabstop = 2
  vim.opt_local.softtabstop = 2
  vim.opt_local.shiftwidth = 2
end)

-- Restore cursor shape on exit
autocmd("VimLeave", "exit_cursor", nil, "set guicursor=a:ver90-blinkwait500-blinkon500-blinkoff250")
