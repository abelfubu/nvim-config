return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    --- @type snacks.Config
    opts = {
      indent = { enabled = false, animate = { enabled = false } },
      lazygit = { enabled = true },
      zen = { toggles = { dim = false }, show = { statusline = true } },
      notifier = { enabled = false },
      terminal = { enabled = true },
      dim = { enabled = false },
      explorer = {
        replace_netrw = true,
      },
      picker = {
        ui_select = true,
        formatters = {
          file = {
            filename_first = true,
          },
        },
        sources = {
          explorer = {
            layout = {
              preset = "vscode",
              cycle = false,
              layout = { position = "right", width = 0.33 },
            },
          },
        },
      },
      dashboard = {
        width = 30,
        enabled = false,
        preset = {
          header = [[
abelfubu
          ]],
          -- stylua: ignore
          keys = {
            { icon = " ", key = "f", desc = "[F]ind File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "[N]ew File", action = ":ene | startinsert" },
            { icon = " ", key = "d", desc = "Fin[d] Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "[R]ecent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "c", desc = "[C]onfig", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})", },
            { icon = " ", key = "s", desc = "Restore [S]ession", section = "session" },
            -- { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "[Q]uit", action = ":qa" },
          },
        },
        sections = {
          -- {
          --   section = "terminal",
          --   padding = 1,
          --   cmd = space_invaders,
          --   height = 10,
          -- },
          { { section = "header" }, { section = "keys", gap = 1, padding = 1 } },
        },
      },
    },
  },
}
