local M = {}

M.servers = {
  vtsls = {
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    settings = {
      complete_function_calls = true,
      vtsls = {
        enableMoveToFileCodeAction = true,
        autoUseWorkspaceTsdk = true,
        experimental = {
          maxInlayHintLength = 30,
          completion = {
            enableServerSideFuzzyMatch = true,
          },
        },
      },
      typescript = {
        updateImportsOnFileMove = { enabled = "always" },
        preferences = {
          includePackageJsonAutoImports = "on",
        },
        suggest = {
          completeFunctionCalls = true,
          autoImports = true,
          includeCompletionsForModuleExports = true,
        },
        inlayHints = {
          enumMemberValues = { enabled = true },
          -- functionLikeReturnTypes = { enabled = true },
          parameterNames = { enabled = "literals" },
          -- parameterTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          variableTypes = { enabled = false },
        },
      },
    },
  },
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
  tailwindcss = {},
  yamlls = {},
  taplo = {
    settings = {
      taplo = {
        schema = {
          associations = {
            [".*sesh\\.toml$"] = "https://github.com/joshmedeski/sesh/raw/main/sesh.schema.json",
          },
        },
      },
    },
  },
}

M.external_server = {
  sourcekit = {},
}

-- Linter and Formatter to be installed by mason
M.other = {
  -- linter
  "shellcheck",
  "hadolint",

  -- formatter
  "stylua",
}

M.all_servers = vim.tbl_extend("force", M.servers, M.external_server)

return M
