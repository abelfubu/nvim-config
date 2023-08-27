return {
  {
    "rest-nvim/rest.nvim",
    deps = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<leader>rs",
        function()
          require("rest-nvim").run(true)
        end,
        desc = "Run REST API",
      },
    },
  },
}
