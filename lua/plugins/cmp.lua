return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = { { "onsails/lspkind.nvim" } },
    opts = function(_, opts)
      local lspkind = require("lspkind")

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
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            vim_item.kind = string.format("%s %s", lspkind.symbol_map[vim_item.kind] or "", vim_item.kind)

            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name]

            return vim_item
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
