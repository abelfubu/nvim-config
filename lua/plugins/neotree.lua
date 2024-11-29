return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    opts = {
      popup_border_style = "rounded",
      window = {
        position = "right",
        width = 75,
        -- popup = {
        --   size = { width = "57", height = "60%" },
        --   position = "50%",
        -- },
      },
      default_component_configs = {
        icon = {
          folder_closed = " ",
          folder_open = " ",
          folder_empty = " ",
        },
      },
    },
  },
}
