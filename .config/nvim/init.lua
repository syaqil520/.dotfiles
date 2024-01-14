-- bootstrap lazy.nvim, LazyVim and your plugins
if vim.g.vscode then
  require("vscode.init")
else
  require("config.lazy")
end
