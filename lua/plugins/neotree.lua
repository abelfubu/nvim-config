return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    keys = {
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").get_root(), reveal = true })
        end,
        desc = "Explorer NeoTree (root dir)",
      },
      {
        "<leader>fE",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd(), reveal = true })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      {
        "<leader>bo",
        function()
          vim.cmd("Neotree buffers reveal")
        end,
        desc = "Explorer NeoTree (Buffers)",
      },
    },
    opts = {
      window = {
        position = "float",
        popup = { -- settings that apply to float position only
          size = { width = "57" },
          position = "50%", -- 50% means center it
        },
      },
      default_component_configs = {
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "",
        },
      },
    },
  },
}
