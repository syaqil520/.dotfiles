vim.diagnostic.config({
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
  underline = true,
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
  } or {},
})

local lspserver = require("config.lspserver")
lspserver.servers.sourcekit = {}

for server, config in pairs(lspserver.servers) do
  vim.lsp.enable(server)
  vim.lsp.config(server, config)
end
