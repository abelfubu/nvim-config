return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local custom_opts = {
        window = {
          completion = {
            border = "rounded",
            winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
          },
          documentation = {
            border = "rounded",
            winhighlight = "Normal:CmpDocNormal,FloatBorder:CmpDocBorder,CursorLine:PmenuSel,Search:None",
          },
        },
        sources = require("cmp").config.sources({
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "codeium" },
        }, {
          { name = "buffer" },
        }),
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, item)
            local icons = LazyVim.config.icons.kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end

            item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
              codeium = "[AI]",
            })[entry.source.name]

            return item
          end,
        },

        experimental = {
          ghost_text = false,
        },
      }

      opts = vim.tbl_deep_extend("force", opts, custom_opts)

      return opts
    end,
  },
}
