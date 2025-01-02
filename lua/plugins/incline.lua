return {
  "b0o/incline.nvim",
  event = "BufReadPre",
  enabled = true,
  priority = 1200,
  opts = function()
    local mocha = require("catppuccin.palettes").get_palette("mocha")
    local helpers = require("incline.helpers")
    local devicons = require("nvim-web-devicons")

    return {
      highlight = {
        groups = {
          InclineNormal = { guibg = mocha.base, guifg = mocha.text },
          InclineNormalNC = { guibg = mocha.base, guifg = mocha.surface0 },
        },
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        if filename == "" then
          filename = "[No Name]"
        end

        local guibg = mocha.mantle

        local ft_icon, ft_color = devicons.get_icon_color(filename)
        local modified = vim.bo[props.buf].modified
        return {
          { "", guifg = ft_color },
          ft_icon and { "", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
          { " " .. filename .. " ", gui = "bold", guibg = guibg },
          modified and " " or "",
          { "", guifg = guibg, guibg = mocha.none },
          guifg = props.focused and mocha.rosewater or mocha.surface2,
        }
      end,
    }
  end,
}
