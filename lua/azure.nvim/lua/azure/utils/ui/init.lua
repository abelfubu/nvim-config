local M = {}

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

return M
