return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true,
    opts = {
      direction = "horizontal",
    },
    keys = {
      {
        "<Leader>t",
        "<CMD>ToggleTerm size=28 direction=horizontal<CR>",
        "ToggleTerm",
      },
      {
        "<Leader>T",
        "<CMD>ToggleTerm size=28 direction=vertical<CR>",
        "ToggleTerm",
      },
    },
  },
}
