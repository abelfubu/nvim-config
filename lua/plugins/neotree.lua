return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    enabled = true,
    opts = {
      popup_border_style = "rounded",
      window = {
        position = "right",
        width = 75,
        -- mappings = {
        --   ["s"] = function(state)
        --     local node = state.tree:get_node()
        --     if node.type == "file" then
        --       vim.cmd("Neotree open_vsplit")
        --       vim.cmd("Neotree close")
        --     end
        --   end,
        -- },
      },
    },
  },
}
