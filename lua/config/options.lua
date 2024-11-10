local event = #vim.fn.argv() > 0 and "VeryLazy" or "UIEnter"

vim.api.nvim_create_autocmd(event, {
  once = true,
  callback = function()
    require("lazyvim.config").load("keymaps")
  end,
})
