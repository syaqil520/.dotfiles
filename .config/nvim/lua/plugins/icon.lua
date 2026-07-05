return {
  "Mirsmog/real-icons.nvim",
  build = ":RealIconsInstallPack material",
  opts = {
    pack = "material",
    integrations = {
      nvim_tree = true,
      snacks_picker = true,
    },
  },
}
