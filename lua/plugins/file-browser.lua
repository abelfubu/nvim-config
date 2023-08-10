return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<leader>fa",
      function()
        require("telescope").extensions.file_browser.file_browser({
          path = "%:p:h",
        })
      end,
      desc = "File Browser",
    },
  },
}
