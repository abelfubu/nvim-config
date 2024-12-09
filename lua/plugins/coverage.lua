return {
  {
    "andythigpen/nvim-coverage",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<leader>tct",
        function()
          local cov = require("coverage")
          cov.toggle()
        end,
        desc = "Coverage Toggle",
      },
      {
        "<leader>tcl",
        function()
          local cov = require("coverage")
          cov.load(true)
        end,
        desc = "Coverage Load",
      },
    },
    opts = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      return {
        commands = true,
        highlights = {
          covered = { fg = mocha.green },
          uncovered = { fg = mocha.red },
        },
        signs = {
          covered = { hl = "CoverageCovered", text = "▎" },
          uncovered = { hl = "CoverageUncovered", text = "▎" },
        },
        summary = {
          min_coverage = 80.0,
        },
        lang = {},
      }
    end,
  },
}
