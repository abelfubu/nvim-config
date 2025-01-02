return {
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true,
      },
      cmdline = {
        view = "cmdline_popup",
        opts = {},
      },
      views = {
        cmdline_popup = {
          position = { row = "40%" },
          size = { width = "auto", height = "auto" },
        },
      },
    },
  },
}
