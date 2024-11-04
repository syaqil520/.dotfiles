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
    vim.opt_local.conceallevel = 0
  end,
})

-- Restore cursor on nvim exit
vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    vim.opt.guicursor = "a:ver25-blinkon50-blinkoff50-blinkwait50"
  end,
})

local lsp_conficts, _ = pcall(vim.api.nvim_get_autocmds, { group = "LspAttach_conflicts" })
if not lsp_conficts then
  vim.api.nvim_create_augroup("LspAttach_conflicts", {})
end

-- For vue project
-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = "LspAttach_conflicts",
--   desc = "prevent tsserver and volar competing",
--   callback = function(args)
--     if not (args.data and args.data.client_id) then
--       return
--     end
--     local active_clients = vim.lsp.get_active_clients()
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     -- prevent tsserver and volar competing
--     -- if client.name == "volar" or require("lspconfig").util.root_pattern("nuxt.config.ts")(vim.fn.getcwd()) then
--     -- OR
--     if client.name == "volar" then
--       for _, client_ in pairs(active_clients) do
--         -- stop tsserver if volar is already active
--         if client_.name == "tsserver" then
--           client_.stop()
--         end
--       end
--     elseif client.name == "tsserver" then
--       for _, client_ in pairs(active_clients) do
--         -- prevent tsserver from starting if volar is already active
--         if client_.name == "volar" then
--           client.stop()
--         end
--       end
--     end
--   end,
-- })

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "html",
    "js",
    "ts",
    "vue",
    "css",
    "scss",
    "lua",
    "dart",
    "typescript.tsx",
    "javascript.jsx",
    "javascriptreact",
    "typescriptreact",
    "dart",
    "json",
    "jsonc",
  },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.autoindent = true
    vim.opt_local.smarttab = true
    vim.opt_local.breakindent = true
  end,
})

-- Disable autoformat for lua files
-- vim.api.nvim_create_autocmd({ "FileType" }, {
--   pattern = { "lua" },
--   callback = function()
--     vim.b.autoformat = false
--   end,
-- })
