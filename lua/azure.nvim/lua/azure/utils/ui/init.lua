local M = {}

---@class CommandPaletteConfig
---@field title string
---@field loader function
---@field previewer function

---@class FuzzyFinder
---@field open function

---Creates a fzf lua fuzzy finder
---@return FuzzyFinder
local function fzf_lua_finder()
  print("fzf-lua found")
  return {
    ---@param config CommandPaletteConfig
    open = function(config)
      print("opening fzf-lua")
      require("fzf-lua").fzf_exec(function(callback)
        config.loader(callback)
      end, { prompt = config.title })
    end,
  }
end

---Creates a telescope fuzzy finder
---@return FuzzyFinder
local function telescope_finder()
  print("telescope found")
  return {
    ---@param config CommandPaletteConfig
    open = function(config)
      print("opening telescope", config)
    end,
  }
end

local function fuzzy_finder_factory()
  if pcall(require, "telescope") then
    return telescope_finder()
  end

  if pcall(require, "fzf-lua") then
    return fzf_lua_finder()
  end

  error("No fuzzy finder plugin found. Please install Telescope or fzf-lua.")
end

function M.show_picker(title, items, main_coroutine)
  local nui_menu = require("nui.menu")
  local event = require("nui.utils.autocmd").event

  local menu_items = vim.tbl_map(function(item)
    return nui_menu.item(item)
  end, items)

  local menu = nui_menu({
    position = "50%",
    size = { width = 60, height = #items },
    border = { style = "rounded", text = { top = title, top_align = "center" } },
  }, {
    lines = menu_items,
    on_close = function()
      coroutine.resume(main_coroutine, nil)
    end,
    on_submit = function(item)
      coroutine.resume(main_coroutine, item.text)
    end,
  })

  menu:mount()
  menu:on(event.BufLeave, function()
    menu:unmount()
  end)

  return coroutine.yield()
end

---Creates a command palette
---@param config CommandPaletteConfig
---@return nil
function M.command_palette(config)
  print("opening command palette")
  local finder = fuzzy_finder_factory()
  print(vim.inspect(finder))
  finder.open(config)
end

vim.keymap.set("n", "<space>xx", "<cmd>source %<cr>", { silent = true })
vim.keymap.set("n", "<space>xc", function()
  M.command_palette({
    title = "Commands",
    loader = function(done)
      for _, command in ipairs({ "Command 1", "Command 2", "Command 3" }) do
        done(command)
      end

      done()
    end,
    previewer = function() end,
  })
end, { silent = true })

return M
