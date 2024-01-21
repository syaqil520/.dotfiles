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

-- Restore cursor on nvim exit
vim.api.nvim_create_autocmd("VimLeave", {
    callback = function()
        vim.opt.guicursor = "a:ver25-blinkon50-blinkoff50-blinkwait50"
    end,
})
