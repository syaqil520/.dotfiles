-- Add quickscope to pack
-- -- vim.cmd([[packadd quickscope]])

-- -- Execute settings.lua
-- vim.cmd("luafile " .. vim.fn.stdpath("config") .. "/lua/settings.lua")

local function manageEditorSize(count, to)
    count = count or 1
    to = to or "increase"

    for _ = 1, count do
        vim.fn["VSCodeNotify"](
            to == "increase" and "workbench.action.increaseViewSize" or "workbench.action.decreaseViewSize"
        )
    end
end

local function vscodeCommentary(...)
    if vim.fn.argc() == 0 then
        vim.bo.operatorfunc = vim.fn.matchstr(vim.fn.expand("<sfile>"), "[^. ]*$")
        return "g@"
    else
        local line1, line2
        if vim.fn.argc() > 1 then
            line1, line2 = ...
        else
            line1, line2 = vim.fn.line("['["), vim.fn.line("']")
        end

        vim.fn["VSCodeCallRange"]("editor.action.commentLine", line1, line2, 0)
    end
end

local function openVSCodeCommandsInVisualMode()
    vim.cmd([[normal! gv]])
    local visualmode = vim.fn.visualmode()
    local startLine, endLine

    if visualmode == "V" then
        startLine, endLine = vim.fn.line("v"), vim.fn.line(".")
        vim.fn["VSCodeNotifyRange"]("workbench.action.showCommands", startLine, endLine, 1)
    else
        local startPos = vim.fn.getpos("v")
        local endPos = vim.fn.getpos(".")
        vim.fn["VSCodeNotifyRangePos"](
            "workbench.action.showCommands",
            startPos[2],
            endPos[2],
            startPos[3],
            endPos[3],
            1
        )
    end
end

local function openWhichKeyInVisualMode()
    vim.cmd([[normal! gv]])
    local visualmode = vim.fn.visualmode()
    local startLine, endLine

    if visualmode == "V" then
        startLine, endLine = vim.fn.line("v"), vim.fn.line(".")
        vim.fn["VSCodeNotifyRange"]("whichkey.show", startLine, endLine, 1)
    else
        local startPos = vim.fn.getpos("v")
        local endPos = vim.fn.getpos(".")
        vim.fn["VSCodeNotifyRangePos"]("whichkey.show", startPos[2], endPos[2], startPos[3], endPos[3], 1)
    end
end

-- Better Navigation
vim.api.nvim_set_keymap("n", "<C-j>", ':lua manageEditorSize(1, "increase")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<C-j>", ':lua manageEditorSize(1, "increase")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", ':lua manageEditorSize(1, "decrease")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<C-k>", ':lua manageEditorSize(1, "decrease")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap(
    "n",
    "<C-h>",
    ':lua vim.fn["VSCodeNotify"]("workbench.action.navigateLeft")<CR>',
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "x",
    "<C-h>",
    ':lua vim.fn["VSCodeNotify"]("workbench.action.navigateLeft")<CR>',
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<C-l>",
    ':lua vim.fn["VSCodeNotify"]("workbench.action.navigateRight")<CR>',
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "x",
    "<C-l>",
    ':lua vim.fn["VSCodeNotify"]("workbench.action.navigateRight")<CR>',
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    "n",
    "gr",
    ':lua vim.fn["VSCodeNotify"]("editor.action.goToReferences")<CR>',
    { noremap = true }
)

vim.api.nvim_set_keymap("x", "<C-/>", ':lua vim.fn["vscodeCommentary"]()<CR>', { expr = true, noremap = true })
vim.api.nvim_set_keymap("n", "<C-/>", ':lua vim.fn["vscodeCommentary"]() . "_"<CR>', { expr = true, noremap = true })

vim.api.nvim_set_keymap(
    "n",
    "<C-w>_",
    ':lua vim.fn["VSCodeNotify"]("workbench.action.toggleEditorWidths")<CR>',
    { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
    "n",
    "<Space>",
    ':lua vim.fn["VSCodeNotify"]("whichkey.show")<CR>',
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap("x", "<Space>", ":lua openWhichKeyInVisualMode()<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("x", "<C-P>", ":lua openVSCodeCommandsInVisualMode()<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("x", "gc", "<Plug>VSCodeCommentary", {})
vim.api.nvim_set_keymap("n", "gc", "<Plug>VSCodeCommentary", {})
vim.api.nvim_set_keymap("o", "gc", "<Plug>VSCodeCommentary", {})
vim.api.nvim_set_keymap("n", "gcc", "<Plug>VSCodeCommentaryLine", {})

vim.api.nvim_set_keymap("n", "<Tab>", ":Tabnext<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<S-Tab>", ":Tabprev<CR>", { noremap = true })

vim.o.clipboard = "unnamedplus"

local keymap = vim.keymap

-- Do things without affecting the registers
keymap.set("n", "x", '"_x')
keymap.set("n", "<Leader>p", '"0p')
keymap.set("n", "<Leader>P", '"0P')
keymap.set("v", "<Leader>p", '"0p')
keymap.set("n", "<Leader>c", '"_c')
keymap.set("n", "<Leader>C", '"_C')
keymap.set("v", "<Leader>c", '"_c')
keymap.set("v", "<Leader>C", '"_C')
keymap.set("n", "<Leader>d", '"_d')
keymap.set("n", "<Leader>D", '"_D')
keymap.set("v", "<Leader>d", '"_d')
keymap.set("v", "<Leader>D", '"_D')

-- center when moving up and down
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
