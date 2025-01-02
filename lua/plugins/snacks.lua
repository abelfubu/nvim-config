return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
		-- stylua: ignore
    opts = {
      indent = { enabled = false, animate = { enabled = false } },
      lazygit = { enabled = true },
      zen = { enabled = true, toggles = { dim = false } },
      notifier = { enabled = false },
      terminal = { enabled = true },
      dim = { enabled = false },
      dashboard = {
        width = 78,
        sections = {
          {
            section = "terminal",
            padding = 1,
            cmd = "pwsh -NoProfile -Command " .. vim.fn.stdpath("config") .. "/assets/space_invaders.ps1",
            height = 10,
          },
          { { section = "keys", gap = 1, padding = 1 } },
        },
      },
    },
  },
}
