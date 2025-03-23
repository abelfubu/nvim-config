local function normalize_path(path)
  return path:gsub("\\", "/")
end

vim.api.nvim_create_user_command("JestCoverageCommand", function()
  local filepath = vim.api.nvim_buf_get_name(0)
  local normalized_filepath = normalize_path(filepath)
  local filename = vim.fn.fnamemodify(normalized_filepath, ":t")

  local jest_command =
    string.format([[npx jest "%s" --coverage --collectCoverageFrom "**/%s"]], filename, filename:gsub("spec.", ""))

  print("Normalized Filepath: ", normalized_filepath)
  print("Constructed Jest Command: ", jest_command)

  vim.fn.setreg("+", jest_command)
  vim.fn.setreg("*", jest_command)

  vim.cmd("new")

  vim.fn.termopen(jest_command)
  vim.api.nvim_buf_set_keymap(0, "n", "q", ":bdelete<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_option_value("number", false, { scope = "local" })
  vim.api.nvim_set_option_value("relativenumber", false, { scope = "local" })
end, {})

vim.keymap.set("n", "<leader>tc", "<cmd>JestCoverageCommand<cr>")

return {}
