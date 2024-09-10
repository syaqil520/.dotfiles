return {
  "mbbill/undotree",
  keys = {
    {
      "<Leader><F5>",
      function()
        vim.cmd.UndotreeToggle()
      end,
      desc = "toggle undo tree",
    },
  },
}
