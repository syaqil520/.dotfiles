return {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters_by_ft = {},
    linters = {
      ["markdownlint-cli2"] = {
        args = { "--config", vim.fn.expand("~") .. "/.config/nvim/.markdown-cli2.yaml", "--" },
      },
      swift = { "swiftlint" },
    },
  },
}
