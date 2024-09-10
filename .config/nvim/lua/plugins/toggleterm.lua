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
        ";t",
        "<CMD>ToggleTerm size=28 direction=horizontal<CR>",
        "ToggleTerm",
      },
      {
        ";T",
        "<CMD>ToggleTerm size=28 direction=vertical<CR>",
        "ToggleTerm",
      },
    },
  },
}
