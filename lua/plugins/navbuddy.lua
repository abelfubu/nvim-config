return {
  "neovim/nvim-lspconfig",
  keys = { { "<leader>cs", "<cmd>Navbuddy<cr>", desc = "Symbols Outline" } },
  dependencies = {
    {
      "SmiteshP/nvim-navbuddy",
      dependencies = {
        "SmiteshP/nvim-navic",
        "MunifTanjim/nui.nvim",
      },
      opts = { lsp = { auto_attach = true } },
    },
  },
}
