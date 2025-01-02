return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
			-- stylua: ignore
      { "<leader>e", function() require("neo-tree.command").execute({ toggle = true }) end, desc = "Neotree toggle" },
    },
    opts = function(_, opts)
      local function on_move(data)
        Snacks.rename.on_rename_file(data.source, data.destination)
      end
      local events = require("neo-tree.events")
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED, handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      })

      return {
        filesystem = {
          follow_current_file = {
            enabled = true,
          },
        },
        popup_border_style = "rounded",
        window = {
          position = "right",
          width = 75,
        },
      }
    end,
  },
}
