return {
  {
    "catppuccin/nvim",
    opts = {
      transparent_background = true,
      no_italic = true,
      integrations = {
        cmp = false,
        alpha = true,
        bufferline = true,
        mason = true,
        neotree = true,
        neotest = true,
        dap = true,
        dap_ui = true,
        treesitter = true,
        notify = true,
        telescope = {
          enabled = true,
          style = "nvchad",
        },
      },
      custom_highlights = function(colors)
        return {
          CmpBorder = { fg = colors.surface1, bg = colors.base },
          CmpPmenu = { bg = colors.base, fg = colors.text },
          CmpItemAbbr = { fg = colors.text },
          CmpItemAbbrMatch = { fg = colors.blue, bold = true },
          CmpItemKind = { fg = colors.pink },
          CmpItemMenu = { fg = colors.sapphire },
          CmpDocNormal = { bg = colors.base, fg = colors.text },
          CmpDocBorder = { bg = colors.base, fg = colors.surface1 },
        }
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
