vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.opt_local.number = false -- Disable line numbers
    vim.opt_local.relativenumber = false -- Disable relative numbers
    vim.api.nvim_buf_set_keymap(0, "t", "<Esc><Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
  end,
})
