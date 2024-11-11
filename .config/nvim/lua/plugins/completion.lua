return {
  {
    "nvim-cmp",
    dependencies = {
      "mlaursen/vim-react-snippets",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-buffer",
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      luasnip.config.setup()

      opts.snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      }

      require("vim-react-snippets").lazy_load()

      opts.experimental.ghost_text = false
      opts.mapping = vim.tbl_deep_extend("force", opts.mapping, {
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-l>"] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { "i", "s" }),
        ["<C-h>"] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { "i", "s" }),
      })
    end,
    config = function(_, opts)
      local cmp = require("cmp")
      cmp.setup(opts)

      -- `/` cmdline setup.
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        completion = { completeopt = "menu,menuone,noinsert" },
        sources = {
          { name = "buffer" },
        },
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        completion = { completeopt = "menu,menuone,noinsert" },
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline", option = {
            ignore_cmds = { "Man", "!" },
          } },
        }),
      })
    end,
  },
}
