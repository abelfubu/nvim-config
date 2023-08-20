return {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    keys = {
      { "<C-h>", ":TmuxNavigateLeft<cr>", desc = "Tmux Navigate Left" },
      { "<C-j>", ":TmuxNavigateDown<cr>", desc = "Tmux Navigate Down" },
      { "<C-k>", ":TmuxNavigateUp<cr>", desc = "Tmux Navigate Up" },
      { "<C-l>", ":TmuxNavigateRight<cr>", desc = "Tmux Navigate Right" },
    },
  },
}
