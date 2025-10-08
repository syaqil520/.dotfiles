return {
  {
    "saghen/blink.cmp",
    event = "VimEnter",
    dependencies = {
      "folke/lazydev.nvim",
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        -- See :h blink-cmp-config-keymap for defining your own keymap
        preset = "default",
        ["<CR>"] = { "accept", "fallback" },

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      },
      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },

      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
          window = {
            border = "rounded",
          },
        },
        list = {
          selection = {
            preselect = true,
            auto_insert = false,
          },
        },
        ghost_text = {
          enabled = true,
          -- Show the ghost text when an item has been selected
          show_with_selection = false,
          -- Show the ghost text when no item has been selected, defaulting to the first item
          show_without_selection = false,
          -- Show the ghost text when the menu is open
          show_with_menu = true,
          -- Show the ghost text when the menu is closed
          show_without_menu = true,
        },
        menu = {
          border = "rounded",
        },
      },

      sources = {
        default = { "lsp", "path", "lazydev", "snippets" },
        providers = {
          lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
          lsp = {
            name = "LSP",
            enabled = true,
            module = "blink.cmp.sources.lsp",
            -- min_keyword_length = 2,
            -- fallbacks = { "snippets", "buffer" },
            score_offset = 90, -- the higher the number, the higher the priority
          },
          path = {
            name = "Path",
            module = "blink.cmp.sources.path",
            score_offset = 25,
            fallbacks = { "snippets", "buffer" },
            -- min_keyword_length = 2,
            opts = {
              trailing_slash = false,
              label_trailing_slash = true,
              get_cwd = function(context)
                return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
              end,
              show_hidden_files_by_default = true,
            },
          },
          snippets = {
            name = "snippets",
            enabled = true,
            max_items = 15,
            min_keyword_length = 2,
            module = "blink.cmp.sources.snippets",
            score_offset = 85, -- the higher the number, the higher the priority
          },
        },
      },

      -- snippets = { preset = "luasnip" },

      -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
      -- which automatically downloads a prebuilt binary when enabled.
      --
      -- By default, we use the Lua implementation instead, but you may enable
      -- the rust implementation via `'prefer_rust_with_warning'`
      --
      -- See :h blink-cmp-config-fuzzy for more information
      fuzzy = { implementation = "lua" },

      -- Shows a signature help window while you type arguments for a function
      signature = {
        enabled = true,
        window = {
          show_documentation = false,
          border = "rounded",
        },
      },
    },
  },
}
