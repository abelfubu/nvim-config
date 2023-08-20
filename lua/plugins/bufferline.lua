return {
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        tab_size = 20,
        show_tab_indicators = true,
        style_preset = require("bufferline").style_preset.no_italic,
      },
    },
    keys = {
      {
        "<leader>bs",
        function()
          vim.cmd("BufferLinePick")
        end,
        desc = "Pick Buffer",
      },
    },
  },
}
