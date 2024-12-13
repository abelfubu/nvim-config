return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    enabled = false,
    keys = {
      { "-", "<cmd>Oil<CR>", desc = "Open parent directory" },
    },
    opts = {
      skip_confirm_for_simple_edits = false,
      default_file_explorer = true,
      columns = { "icon" },
      keymaps = {
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["<M-h>"] = "actions.select_split",
        ["q"] = "actions.close",
        ["<C-s>"] = false,
        ["<C-v>"] = function()
          require("oil").select({ vertical = true })
          require("oil").close()
        end,
      },
      view_options = {
        show_hidden = true,
      },
    },
  },
}
