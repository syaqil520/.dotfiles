return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Useful status updates for LSP.
      { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
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
    end,
  },
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      -- Allows extra capabilities provided by blink.cmp
      "saghen/blink.cmp",
    },
    opts = {
      servers = {
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
      },
    },
    config = function(_, opts)
      require("mason").setup()

      local ensure_installed = vim.tbl_keys(opts.servers or {})
      -- add other tool to install such as formatter or linter, for lsp setup in opts
      vim.list_extend(ensure_installed, {
        "stylua",
        "shellcheck",
        "hadolint",
      })
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      local capabilities = require("blink.cmp").get_lsp_capabilities()
      require("mason-lspconfig").setup({
        automatic_enable = true,
        ensure_installed = {}, -- installed with mason-tool-installer
      })

      local servers = opts.servers
      servers.sourcekit = {}
      for server, config in pairs(opts.servers) do
        -- vim.lsp.config(server, config)
        config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end

      -- workaround for gopls not supporting semanticTokensProvider
      -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
      -- vim.api.nvim_create_autocmd("LspAttach", {
      --   callback = function(args)
      --     local client = vim.lsp.get_client_by_id(args.data.client_id)
      --     if client and (not "gopls" or client.name == "gopls") then
      --       if not client.server_capabilities.semanticTokensProvider then
      --         local semantic = client.config.capabilities.textDocument.semanticTokens
      --         client.server_capabilities.semanticTokensProvider = {
      --           full = true,
      --           legend = {
      --             tokenTypes = semantic.tokenTypes,
      --             tokenModifiers = semantic.tokenModifiers,
      --           },
      --           range = true,
      --         }
      --       end
      --     end
      --   end,
      -- })
    end,
  },
}
