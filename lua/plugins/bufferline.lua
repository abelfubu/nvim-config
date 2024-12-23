return {
  {
    "akinsho/bufferline.nvim",
    enabled = false,
    opts = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      return {
        options = {
          tab_size = 30,
          max_name_length = 28,
          style_preset = require("bufferline").style_preset.no_italic,
          show_buffer_close_icons = false,
          color_icons = false,
          diagnostics = false,
          separator_style = "none",
          indicator = {
            style = "none",
          },
        },
        highlights = {
          separator = {
            fg = mocha.base,
          },
          buffer_selected = {
            fg = mocha.peach,
          },
        },
      }
    end,
  },
}
