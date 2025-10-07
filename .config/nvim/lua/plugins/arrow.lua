return {
  "otavioschwanck/arrow.nvim",
  dependencies = {
    { "nvim-tree/nvim-web-devicons" },
  },
  config = function()
    vim.keymap.set("n", "<tab>", require("arrow.persist").previous, { desc = "Move to next arrow persist" })
    vim.keymap.set("n", "<S-tab>", require("arrow.persist").next, { desc = "Move to previous arrow persist" })
    require("arrow").setup({

      show_icons = true,
      leader_key = "m", -- Recommended to be a single key
      buffer_leader_key = "M", -- Per Buffer Mappings
    })
  end,
}
