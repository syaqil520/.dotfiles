-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
-- -- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    command = "set nopaste",
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "json", "jsonc", "markdown" },
    callback = function()
        vim.opt.conceallevel = 0
    end,
})

vim.api.nvim_create_augroup("RestoreCursorStyle", { clear = true })
vim.api.nvim_create_autocmd("VimLeave", {
    pattern = "*",
    group = "RestoreCursorStyle",
    command = 'silent !echo -ne "e[5 q"',
})
