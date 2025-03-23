return {
  {
    "dhruvmanila/browser-bookmarks.nvim",
    opts = {
      selected_browser = "brave",
      config_dir = "/home/abel/.dotfiles/BraveSoftware/Brave-Browser",
    },
    keys = { { "<leader>sB", "<CMD>BrowserBookmarks raindrop<CR>", { desc = "Fuzzy search browser bookmarks" } } },
  },
}
