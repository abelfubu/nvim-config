local palette = require("theme.palette").palettes[vim.g.palette]

local get_icon_by_lsp = function(client_name)
  local lsp_map = {
    angularls = "󰚿",
    lua_ls = "󰢱",
    eslint = "",
    vtsls = "",
    gopls = "",
    tsserver = "",
    cssls = "",
    rustls = "󱘗",
    html = "",
    emmet_ls = "󰟛",
    jsonls = "",
    copilot = "",
    marksman = "󰽛",
    omnisharp = "",
  }

  return lsp_map[client_name] or "uknown-lsp"
end

---@class LualineItem
---@field color function|string
---@field value function|string
---@field icon string
---@field cond? function
---@field format? function

---Creates a lua line item
---@param items LualineItem[]
local create_lualine_items = function(items)
  local result = {}

  for _, item in ipairs(items) do
    table.insert(result, {
      function()
        return ""
      end,
      padding = { left = 1, right = 0 },
      separator = { left = "", right = "" },
      color = { fg = palette.surface1, bg = "None" },
      cond = item.cond or function()
        return true
      end,
    })
    table.insert(result, {
      item.value,
      icon = { item.icon .. "->" },
      separator = "",
      padding = 0,
      color = function()
        local fg = type(item.color) == "function" and item.color() or item.color
        return { fg = fg, bg = "None" }
      end,
      cond = item.cond or function()
        return true
      end,
    })
    table.insert(result, {
      function()
        return ""
      end,
      padding = { left = 0, right = 1 },
      separator = "",
      color = { fg = palette.surface1, bg = "None" },
      cond = item.cond or function()
        return true
      end,
    })
  end

  return result
end

return {
  {
    "nvim-lualine/lualine.nvim",
    enabled = true,
    event = "VeryLazy",
    opts = function()
      local lualine_require = require("lualine_require")

      lualine_require.require = require

      vim.o.laststatus = vim.g.lualine_laststatus

      local opts = {
        options = {
          globalstatus = true,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = {
            {
              "mode",
              padding = { left = 1, right = 0 },
              separator = "",
              color = { fg = palette.blue, gui = "bold", bg = "None" },
              fmt = function(str)
                local modeMap = {
                  NORMAL = " ",
                  INSERT = " ",
                  VISUAL = "󰕢 ",
                  REPLACE = "󰛔 ",
                  COMMAND = " ",
                  TERMINAL = " ",
                  ["V-LINE"] = "󰒉 ",
                  ["V-BLOCK"] = "󰩭 ",
                }

                return (modeMap[str] or "")
              end,
            },
          },
          lualine_b = {
            {
              "branch",
              icon = { "󰊢", align = "left" },
              separator = "",
              padding = { left = 1, right = 1 },
              color = { fg = palette.yellow, gui = "bold", bg = "None" },
            },
          },
          lualine_c = {
            {
              "diagnostics",
              separator = "",
            },
            {
              "diff",
              symbols = {
                added = " ",
                modified = " ",
                removed = " ",
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
            {
              "buffers",
              buffers_color = {
                active = { fg = palette.green, bg = palette.none },
                inactive = { fg = palette.text, bg = palette.none },
              },
              fmt = function(bname)
                if bname == "[No Name]" then
                  return " "
                end

                return bname
              end,
            },
          },
          lualine_x = create_lualine_items({
            {
              icon = "󰄀",
              color = palette.red,
              value = function()
                local rec = vim.fn.reg_recording()
                if rec ~= "" then
                  return "@" .. rec
                end
                return ""
              end,
              cond = function()
                return vim.fn.reg_recording() ~= ""
              end,
            },
          }),
          lualine_y = create_lualine_items({
            {
              color = palette.text,
              icon = "",
              value = function()
                local buf = vim.api.nvim_get_current_buf()
                local baf = vim.b[buf].autoformat
                return string.format(
                  " %s  %s",
                  -- vim.g.autoformat and "" or "",
                  -- baf == false and "" or ""
                  vim.g.autoformat and "true" or "false",
                  baf == false and "false" or "true"
                )
              end,
            },
          }),
          lualine_z = create_lualine_items({
            {
              color = palette.blue,
              icon = "󰗊",
              value = function()
                local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })

                if #clients == 0 then
                  return " "
                end

                local names = vim.tbl_map(function(client)
                  return get_icon_by_lsp(client.name)
                end, clients)

                return table.concat(names, " ") .. " "
              end,
            },
            {
              color = palette.pink,
              icon = "󰴊",
              value = function()
                return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
              end,
            },
          }),
        },
        extensions = { "neo-tree", "lazy" },
      }

      return opts
    end,
  },
}
