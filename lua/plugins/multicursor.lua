return {
  {
    "brenton-leighton/multiple-cursors.nvim",
    version = "*",
    opts = {},
    keys = {
      {
        "<leader>mj",
        "<Cmd>MultipleCursorsAddDown<CR>",
        mode = { "n", "x" },
        desc = "Add cursor and move down",
      },
      {
        "<leader>mk",
        "<Cmd>MultipleCursorsAddUp<CR>",
        mode = { "n", "x" },
        desc = "Add cursor and move up",
      },
      {
        "<C-LeftMouse>",
        "<Cmd>MultipleCursorsMouseAddDelete<CR>",
        mode = { "n", "i" },
        desc = "Add or remove cursor",
      },
      {
        "<Leader>ma",
        "<Cmd>MultipleCursorsAddMatches<CR>",
        mode = { "n", "x" },
        desc = "Add cursors to cword",
      },
      {
        "<Leader>mA",
        "<Cmd>MultipleCursorsAddMatchesV<CR>",
        mode = { "n", "x" },
        desc = "Add cursors to cword in previous area",
      },
      {
        "<leader>md",
        "<Cmd>MultipleCursorsAddJumpNextMatch<CR>",
        mode = { "n", "x" },
        desc = "Add cursor and jump to next cword",
      },
      {
        "<leader>ms",
        "<Cmd>MultipleCursorsJumpNextMatch<CR>",
        mode = { "n", "x" },
        desc = "Jump to next cword",
      },

      {
        "<Leader>ml",
        "<Cmd>MultipleCursorsLock<CR>",
        mode = { "n", "x" },
        desc = "Lock virtual cursors",
      },
      {
        "n",
        "<Leader>m|",
        function()
          require("multiple-cursors").align()
        end,
        desc = "Align multi cursors",
      },
    },
  },
}
