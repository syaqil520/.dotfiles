return {
  "rachartier/tiny-code-action.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "folke/snacks.nvim" },
  },
  event = "LspAttach",
  opts = {},
  keys = {
    {
      "<leader>ca",
      function()
        require("tiny-code-action").code_action()
      end,
      { desc = "Code Action", noremap = true, silent = true },
    },
  },
}
