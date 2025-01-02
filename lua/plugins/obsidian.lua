return {
  "epwalsh/obsidian.nvim",
  version = "*",
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "Brain",
        path = os.getenv("USERPROFILE") .. "/Documents/Brain",
      },
    },
  },
}
