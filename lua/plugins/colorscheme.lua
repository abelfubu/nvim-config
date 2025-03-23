return {
  {
    "catppuccin/nvim",
    priority = 1000,
    lazy = true,
    name = "catppuccin",
    opts = {
      transparent_background = true,
      no_italic = true,
      integrations = {
        flash = true,
        fzf = true,
        gitsigns = true,
        headlines = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        neotest = true,
        neotree = true,
        noice = true,
        semantic_tokens = true,
        snacks = true,
        blink_cmp = true,
        treesitter = true,
        treesitter_context = true,
      },
      custom_highlights = function(colors)
        return {
          BlinkCmpMenuBorder = { fg = colors.blue },
          BlinkCmpMenu = { bg = colors.base },
          CursorLine = { bg = colors.none },
        }
      end,
      color_overrides = {
        mocha = require("theme.palette").get_palette(vim.g.palette),
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = {
        bg = true,
        float = true,
      },
    },
  },
}
