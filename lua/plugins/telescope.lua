return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find Plugin File",
      },
    },
    opts = {
      defaults = {
        path_display = function(_, path)
          local lastSlashIndex = path:find("[^/]*$")

          if not lastSlashIndex then
            return path
          end

          return path:sub(lastSlashIndex)
        end,
        prompt_prefix = "   ",
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },
}
