local M = {}

function M.execute_command(command)
  local handle = io.popen(command, "r")

  if not handle then
    error("Failed to execute command: " .. command)
  end

  local result = handle:read("*a")

  handle:close()

  if not result or result == "" then
    return nil, "Command returned empty output"
  end

  local ok, decoded = pcall(vim.json.decode, result)

  if not ok then
    return nil, "Failed to decode JSON: " .. decoded
  end

  return decoded
end

return M
