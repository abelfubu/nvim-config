return {
  {
    "nvim-telescope/telescope.nvim",
    enabled = true,
    keys = {
      {
        "<leader>fp",
        function()
          -- require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
          require("telescope.builtin").find_files()
        end,
        desc = "Find Plugin File",
      },
    },
    opts = {
      defaults = {
        path_display = { "filename_first" },
        prompt_prefix = "   ",
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top", width = 0.70, height = 0.65 },
        sorting_strategy = "ascending",
        winblend = 0,
        mappings = {
          i = {
            ["<C-p>"] = require("telescope.actions.layout").toggle_preview,
          },
        },
        preview = {
          hide_on_startup = true,
        },
      },
    },
  },
}
