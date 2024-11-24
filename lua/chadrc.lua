local M = {}

M.base46 = {
  theme = "nord",
  transparency = true,
}

M.ui = {
  cmp = {
    lspkind_text = true,
    style = "default", -- default/flat_light/flat_dark/atom/atom_colored
    format_colors = {
      tailwind = true,
    },
  },

  -- telescope = { style = "borderless" }, -- borderless / bordered

  statusline = {
    theme = "default",
    separator_style = "round",
  },
}

return M
