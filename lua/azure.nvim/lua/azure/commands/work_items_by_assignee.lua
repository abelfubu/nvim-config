-- This is just a test
--
require("fzf-lua").fzf_live(function(query)
  return string.format(
    [[ pwsh -NoProfile -Command "az boards query -o table --wiql \"SELECT [System.Id], [System.Title], [System.AssignedTo] FROM WorkItems Where [System.AssignedTo] contains '%s'\"" ]],
    query
  )
end, {
  fn_transform = function(item)
    if type(tonumber(item:sub(1, 6))) ~= "number" then
      return nil
    end

    return item
  end,
})

vim.keymap.set("n", "<leader>x", "<cmd>source %<cr>")
