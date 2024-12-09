return {
  {
    "folke/zen-mode.nvim",
    keys = {
      { "<leader>zz", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
    },
    opts = {},
  },
  {
    "folke/twilight.nvim",
    keys = {
      { "<leader>zf", "<cmd>Twilight<cr>", desc = "Toggle Twilight" },
    },

    opts = {
      dimming = {
        alpha = 0.25,
      },
    },
  },
}
