return {
  {
    "catppuccin/nvim",
    opts = {
      transparent_background = true,
      integrations = {
        cmp = true,
        alpha = true,
        bufferline = true,
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
