local highlights = require("bufferline.highlights")
return {
  {
    "akinsho/bufferline.nvim",
    opts = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      return {
        options = {
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
