return {
  "Mirsmog/real-icons.nvim",
  build = ":RealIcons install",
  opts = {
    integrations = {
      nvim_tree = true,
      snacks_picker = true,
      oil = true,
    },
  },
}
