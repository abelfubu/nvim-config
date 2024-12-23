return {
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>qo", require("snacks").dashboard.open, desc = "Snacks open dashboard" },
    },
    opts = {
      indent = { animate = { enabled = false }, enabled = false },
      dashboard = {
        sections = {
          {
            section = "terminal",
            cmd = "ascii-image-converter /mnt/c/Users/abelfubu/Downloads/93489351.png --color -c",
            padding = 1,
            height = 26,
          },
          {
            { pane = 2, section = "keys", gap = 1, padding = 1 },
            { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", padding = 2 },
            { pane = 2, section = "startup", padding = { 1, 2 } },
          },
        },
        {
          -- stylua: ignore
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
    },
  },
}
