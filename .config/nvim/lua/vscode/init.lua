local vscode = require("vscode-neovim")
local keymap = vim.keymap
local nsOpts = { noremap = true, silent = true }

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

-- options

vim.o.clipboard = "unnamedplus"

-- keymap

-- navigate between explorer
keymap.set("n", "<C-h>", function()
    vscode.action("workbench.action.navigateLeft")
end, nsOpts)

keymap.set("x", "<C-h>", function()
    vscode.action("workbench.action.navigateLeft")
end, nsOpts)

keymap.set("n", "<C-l>", function()
    vscode.action("workbench.action.navigateLeft")
end, nsOpts)

keymap.set("x", "<C-l>", function()
    vscode.action("workbench.action.navigateRight")
end, nsOpts)

-- lsp
keymap.set("n", "gr", function()
    vscode.action("editor.action.goToReferences")
end, nsOpts)

-- navigate between tab
keymap.set("n", "<S-l>", ":Tabnext<CR>", nsOpts)
keymap.set("n", "<S-h>", ":Tabprev<CR>", nsOpts)

-- comment action
vim.api.nvim_set_keymap("x", "gc", "<Plug>VSCodeCommentary", {})
vim.api.nvim_set_keymap("n", "gc", "<Plug>VSCodeCommentary", {})
vim.api.nvim_set_keymap("o", "gc", "<Plug>VSCodeCommentary", {})
vim.api.nvim_set_keymap("n", "gcc", "<Plug>VSCodeCommentaryLine", {})

-- quick action
vim.api.nvim_set_keymap("x", "<C-P>", ":lua openVSCodeCommandsInVisualMode()<CR>", { noremap = true, silent = true })

keymap.set("n", "<Space><Space>", function()
    vscode.action("workbench.action.quickOpen")
end, nsOpts)

keymap.set("x", "<Space><Space>", function()
    vscode.action("workbench.action.quickOpen")
end, nsOpts)

-- window normal binding
vim.api.nvim_set_keymap(
    "n",
    "<C-a>",
    ':lua vim.fn["VSCodeNotify"]("editor.action.selectAll")<CR>',
    { noremap = true, silent = true }
)

-- close editor
keymap.set("n", "<Space>bd", function()
    vscode.action("workbench.action.closeActiveEditor")
end, nsOpts)

-- split
keymap.set("n", "<Space>w-", function()
    vscode.action("workbench.action.splitEditorDown")
end, nsOpts)

keymap.set("x", "<Space>w-", function()
    vscode.action("workbench.action.splitEditorDown")
end, nsOpts)

keymap.set("n", "<Space>w|", function()
    vscode.action("workbench.action.splitEditorRight")
end, nsOpts)

keymap.set("x", "<Space>w|", function()
    vscode.action("workbench.action.splitEditorRight")
end, nsOpts)

-- workaround for dirty "unmodified" with vim undo
vim.keymap.set("n", "u", function()
    vscode.action("undo")
end, { noremap = true })

vim.keymap.set("n", "<C-r>", function()
    vscode.action("redo")
end, { noremap = true })

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
