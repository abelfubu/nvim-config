local function normalize_path(path)
  return path:gsub("\\", "/")
end

local function run_command_with_colors(command)
  vim.cmd("new")

  local buf = vim.api.nvim_get_current_buf()

  vim.fn.termopen(command)
  vim.api.nvim_buf_set_keymap(buf, "n", "q", ":bdelete<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_option_value("number", false, { scope = "local" })
  vim.api.nvim_set_option_value("relativenumber", false, { scope = "local" })
end

vim.api.nvim_create_user_command("JestCoverageCommand", function()
  -- Get and normalize the full file path
  local filepath = vim.api.nvim_buf_get_name(0)
  local normalized_filepath = normalize_path(filepath)
  local filename = vim.fn.fnamemodify(normalized_filepath, ":t")

  -- Construct the Jest command
  local jest_command =
    string.format([[npx jest "%s" --coverage --collectCoverageFrom "**/%s"]], filename, filename:gsub("jest.spec.", ""))

  print("Normalized Filepath: ", normalized_filepath)
  print("Constructed Jest Command: ", jest_command)

  -- Copy the Jest command to the clipboard
  vim.fn.setreg("+", jest_command)
  vim.fn.setreg("*", jest_command)

  -- Run the Jest command in a new terminal buffer
  run_command_with_colors(jest_command)
end, {})

vim.keymap.set("n", "<leader>tcc", "<cmd>JestCoverageCommand<cr>")

return {}
