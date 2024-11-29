return {
  {
    "catppuccin/nvim",
    opts = {
      transparent_background = true,
      integrations = {
        cmp = true,
        alpha = true,
        bufferline = false,
        mason = true,
        neotree = true,
        neotest = true,
        dap = true,
        dap_ui = true,
        treesitter = true,
        telescope = {
          enabled = true,
          style = "nvchad",
        },
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
