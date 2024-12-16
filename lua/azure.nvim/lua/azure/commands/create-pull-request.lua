local ui = require("azure.utils.ui")

local M = {}

function M.azure_create_pr()
  local co = coroutine.running()
  if not co then
    error("This function must be called from within a coroutine.")
  end

  local pr_types = { "FEAT", "FIX", "CHORE", "REFACTOR", "DOCS" }
  local branches = { "develop", "feature/jest-migration" }

  local pr_type = ui.show_picker("Pick PR Type", pr_types, co)
  if not pr_type then
    print("PR type selection canceled.")
    return
  end

  local branch = ui.show_picker("Pick Destination Branch", branches, co)
  if not branch then
    print("Branch selection canceled.")
    return
  end

  local title = vim.fn.input("Title")
  local description = vim.fn.input("Description")

  if title == "" or description == "" then
    print("Title and description are required to create a PR.")
    return
  end

  local create_command = string.format(
    'az repos pr create --title "%s" --description "%s" --type "%s" --target-branch "%s"',
    title,
    description,
    pr_type,
    branch
  )
  print(create_command)
  --
  -- local result, error = utils.execute_command(create_command)
  -- if error then
  --   print("Failed to create PR: " .. error)
  -- else
  --   print("Pull Request created successfully:", result)
  -- end
end

return M
