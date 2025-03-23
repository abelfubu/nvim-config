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
    templates = {
      folder = "Templates",
    },
    daily_notes = {
      folder = "Daily Notes",
      template = "Daily Note.md",
    },
  },
}
