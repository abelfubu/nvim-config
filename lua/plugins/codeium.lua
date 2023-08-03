return {
  {
    "Exafunction/codeium.vim",
    lazy = false,
    keys = {
      {
        "<C-a>",
        function()
          return vim.fn["codeium#Accept"]()
        end,
        expr = true,
        desc = "Confirm Selection",
        mode = { "i" },
      },
      {
        "<C-x>",
        function()
          return vim.fn["codeium#Clear"]()
        end,
        expr = true,
        desc = "Clear Selection",
        mode = { "i" },
      },
      {
        "<C-;>",
        function()
          return vim.fn["codeium#CycleCompletions"](1)
        end,
        expr = true,
        desc = "Cycle Completions",
        mode = { "i" },
      },
      {
        "<C-,>",
        function()
          return vim.fn["codeium#CycleCompletions"](-1)
        end,
        expr = true,
        desc = "Cycle Completions",
        mode = { "i" },
      },
    },
  },
}
