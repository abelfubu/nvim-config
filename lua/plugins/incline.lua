return {
  "b0o/incline.nvim",
  event = "BufReadPre",
  enabled = true,
  priority = 1200,
  opts = function()
    local palette = require("theme.palette").get_palette("everforest")
    local helpers = require("incline.helpers")
    local devicons = require("nvim-web-devicons")

    return {
      highlight = {
        groups = {
          InclineNormal = { guibg = palette.base, guifg = palette.text },
          InclineNormalNC = { guibg = palette.base, guifg = palette.subtext0 },
        },
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        if filename == "[No Name]" then
          filename = ""
        end

        local guibg = palette.base

        local ft_icon, ft_color = devicons.get_icon_color(filename)
        local modified = vim.bo[props.buf].modified
        return {
          { "", guifg = ft_color },
          ft_icon and { "", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
          { " " .. filename .. " ", gui = "bold", guibg = guibg },
          modified and " " or "",
          { "", guifg = guibg, guibg = palette.base },
          guifg = props.focused and palette.text or palette.surface1,
        }
      end,
    }
  end,
}
