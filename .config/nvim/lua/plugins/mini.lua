return {
  {
    "nvim-mini/mini.pairs",
    -- enabled = false,
    opts = {
      modes = { insert = true, command = true, terminal = false },
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      skip_ts = { "string" },
      skip_unbalanced = true,
      markdown = true,
    },
    config = function(_, opts)
      local pairs = require("mini.pairs")

      pairs.setup(opts)

      local open = pairs.open

      pairs.open = function(pair, neigh_pattern)
        local o, c = pair:sub(1, 1), pair:sub(2, 2)

        local line = vim.api.nvim_get_current_line()

        local cursor = vim.api.nvim_win_get_cursor(0)

        local next = line:sub(cursor[2] + 1, cursor[2] + 1)

        local before = line:sub(1, cursor[2])

        if opts.markdown and o == "`" and vim.bo.filetype == "markdown" and before:match("^%s*``") then
          return "`\n```" .. vim.api.nvim_replace_termcodes("<up>", true, true, true)
        end

        if opts.skip_next and next ~= "" and next:match(opts.skip_next) then
          return o
        end

        if opts.skip_unbalanced and next == c and c ~= o then
          local _, count_open = line:gsub(vim.pesc(pair:sub(1, 1)), "")

          local _, count_close = line:gsub(vim.pesc(pair:sub(2, 2)), "")

          if count_close > count_open then
            return o
          end
        end

        return open(pair, neigh_pattern)
      end
    end,
  },
  {
    "nvim-mini/mini.ai",
    event = "VeryLazy",
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({ -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
          d = { "%f[%d]%d+" }, -- digits
          e = { -- Word with case
            { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
            "^().*()$",
          },
          u = ai.gen_spec.function_call(), -- u for "Usage"
          U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
        },
      }
    end,
  },
  {
    "nvim-mini/mini.surround",
    opts = {
      mappings = {
        add = "sa", -- Add surrounding in Normal and Visual modes
        delete = "sd", -- Delete surrounding
        find = "sf", -- Find surrounding (to the right)
        find_left = "sF", -- Find surrounding (to the left)
        highlight = "sh", -- Highlight surrounding
        replace = "sr", -- Replace surrounding
      },
    },
  },
  {
    "nvim-mini/mini.splitjoin",
    version = "*",
    opts = {
      mappings = {
        toggle = "gss",
      },
    },
  },
  {
    "nvim-mini/mini.icons",
    version = false,
    lazy = false,
    config = function()
      require("mini.icons").setup()
      MiniIcons.mock_nvim_web_devicons()
    end,
  },
  { "nvim-mini/mini.align", version = false, opts = {} },
}
