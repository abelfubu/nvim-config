return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local icons = require("lazyvim.config").icons
      local Util = require("lazyvim.util")
      return {
        options = {
          theme = "auto",
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha" } },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = {
            {
              "mode",
              icons_enabled = true,
              -- icon = { "" },
              padding = { left = 1, right = 1 },
              separator = { left = "", right = "" },
              fmt = function(str)
                if str == "NORMAL" then
                  return " Ɲʘ𝖗𝚖ã𝙡"
                elseif str == "INSERT" then
                  return " 𝕀𝒏𐍃𝕖𝕣𝘵"
                elseif str == "VISUAL" then
                  return "󰕢 𝓥ì𝓼𝖚𝖆ɩ"
                elseif str == "V-LINE" then
                  return "󰒉 ▪︎•νℓ𝗶ⲡ𝚎•▪︎"
                elseif str == "V-BLOCK" then
                  return "󰩭 ⇝𝑽Ⲃļ𝗈c𝒌⇝"
                elseif str == "REPLACE" then
                  return "󰛔 [𝐫ėᴩ𝗅𝐚cė]"
                elseif str == "COMMAND" then
                  return " ɕ𝒐ṃṃɐⲡԃ"
                elseif str == "TERMINAL" then
                  return " 𝕥ₑŕოǐȵăɭ"
                end
              end,
            },
          },
          lualine_b = {
            {
              "branch",
              icon = { "󰊢", align = "left" },
            },
          },
          lualine_c = {
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            { "filetype", icon_only = true, separator = " ", padding = { left = 1, right = 0 } },
            {
              "filename",
              path = 1,
              padding = { left = 0, right = 1 },
              symbols = { modified = "  ", readonly = "", unnamed = "" },
              -- fmt = function(file)
              --   return file:match("^.+/(.+)$")
              -- end,
              fmt = function(path)
                local lastSlashIndex = path:find("[^/]*$")

                if not lastSlashIndex then
                  return path
                end

                return path:sub(lastSlashIndex)
              end,
            },
            {
              function()
                return require("nvim-navic").get_location()
              end,
              cond = function()
                return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
              end,
              padding = { left = 1, right = 0 },
              separator = { left = "|", right = "" },
            },
          },
          lualine_x = {
            {
              function()
                return require("noice").api.status.command.get()
              end,
              cond = function()
                return package.loaded["noice"] and require("noice").api.status.command.has()
              end,
              color = Util.fg("Statement"),
            },
            {
              function()
                return require("noice").api.status.mode.get()
              end,
              cond = function()
                return package.loaded["noice"] and require("noice").api.status.mode.has()
              end,
              color = Util.fg("Constant"),
            },
            {
              function()
                return "  " .. require("dap").status()
              end,
              cond = function()
                return package.loaded["dap"] and require("dap").status() ~= ""
              end,
              color = Util.fg("Debug"),
            },
            { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = Util.fg("Special") },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
            },
          },
          lualine_y = {
            {
              function()
                return "󰃰"
              end,
              separator = { left = "" },
              padding = { left = 0, right = 1 },
            },
          },
          lualine_z = {
            {

              function()
                -- return os.date("%R")
                return os.date("%Y-%m-%d   %H:%M") .. " 󰕷  "
              end,
              padding = { left = 1, right = 1 },
              separator = { left = "" },
            },
          },
        },
        extensions = { "neo-tree", "lazy" },
      }
    end,
  },
}
