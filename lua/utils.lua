M = {}

local function create_gradient(start, finish, steps)
  local r1, g1, b1 =
    tonumber("0x" .. start:sub(2, 3)), tonumber("0x" .. start:sub(4, 5)), tonumber("0x" .. start:sub(6, 7))
  local r2, g2, b2 =
    tonumber("0x" .. finish:sub(2, 3)), tonumber("0x" .. finish:sub(4, 5)), tonumber("0x" .. finish:sub(6, 7))

  local r_step = (r2 - r1) / steps
  local g_step = (g2 - g1) / steps
  local b_step = (b2 - b1) / steps

  local gradient = {}
  for i = 1, steps do
    local r = math.floor(r1 + r_step * i)
    local g = math.floor(g1 + g_step * i)
    local b = math.floor(b1 + b_step * i)
    table.insert(gradient, string.format("#%02x%02x%02x", r, g, b))
  end

  return gradient
end

M.apply_gradient_hl = function(start, finish, text)
  local gradient = create_gradient(start, finish, #text)

  local lines = {}
  for i, line in ipairs(text) do
    local tbl = {
      type = "text",
      val = line,
      opts = {
        hl = "HeaderGradient" .. i,
        shrink_margin = false,
        position = "center",
      },
    }
    table.insert(lines, tbl)

    -- create hl group
    vim.api.nvim_set_hl(0, "HeaderGradient" .. i, { fg = gradient[i] })
  end

  return {
    type = "group",
    val = lines,
    opts = { position = "center" },
  }
end

return M
