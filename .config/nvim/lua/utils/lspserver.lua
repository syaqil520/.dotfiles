local M = {}

M.servers = {
  ts_ls = {},
  lua_ls = {},
  bashls = {},
  dockerls = {},
  docker_compose_language_service = {},
  gopls = {
    gofumpt = true,
    codelenses = {
      gc_details = false,
      generate = true,
      regenerate_cgo = true,
      run_govulncheck = true,
      test = true,
      tidy = true,
      upgrade_dependency = true,
      vendor = true,
    },
    hints = {
      assignVariableTypes = true,
      compositeLiteralFields = true,
      compositeLiteralTypes = true,
      constantValues = true,
      functionTypeParameters = true,
      parameterNames = true,
      rangeVariableTypes = true,
    },
    analyses = {
      nilness = true,
      unusedparams = true,
      unusedwrite = true,
      useany = true,
    },
    usePlaceholders = true,
    completeUnimported = true,
    staticcheck = true,
    directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
    semanticTokens = true,
  },
  jsonls = {},
  marksman = {},
  prismals = {},
  tailwindcss = {},
  yamlls = {},
}

-- Linter and Formatter to be installed by mason
M.other = {
  -- linter
  "shellcheck",
  "hadolint",
  -- formatter
  "stylua",
}

return M
