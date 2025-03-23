return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      inlay_hints = { enabled = false },
      diagnostics = {
        virtual_text = true,
        float = { header = false, border = "rounded", focusable = true, auto = true },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.INFO] = "",
          },
        },
      },
      servers = {
        emmet_ls = {
          filetypes = {
            "html",
            -- "typescriptreact",
            -- "javascriptreact",
            "css",
            "sass",
            "scss",
            "less",
            -- "javascript",
            -- "typescript",
            "markdown",
            "ejs",
          },
          init_options = {
            html = {
              options = {
                -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L26
                ["bem.enabled"] = true,
              },
            },
          },
        },
      },
    },
  },
}
