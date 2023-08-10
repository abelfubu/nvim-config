return {
  {
    -- "abelfubu/colorscheme.nvim",
    name = "everforest",
    priority = 1000,
    dir = "~/dev/colorscheme.nvim/",
    dev = true,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everforest",
    },
  },
}
