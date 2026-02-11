return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" }, -- if you use standalone mini plugins
    opts = {
      heading = {
        position = "inline",
        border = true,
      },
      code = {
        width = "block",
        min_width = 45,
        left_pad = 2,
        language_pad = 2,
        position = "right",
      },
      completions = {
        lsp = {
          enabled = false,
        },
      },
    },
    ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
    config = function(_, opts)
      require("render-markdown").setup(opts)
      Snacks.toggle({
        name = "Render Markdown",
        get = require("render-markdown").get,
        set = require("render-markdown").set,
      }):map("<leader>um")
    end,
  },
}
