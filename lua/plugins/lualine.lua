return {
  {
    "nvim-lualine/lualine.nvim",
    enabled = true,
    event = "VeryLazy",
    opts = function()
      local lualine_require = require("lualine_require")
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      lualine_require.require = require

      local icons = LazyVim.config.icons

      vim.o.laststatus = vim.g.lualine_laststatus

      local opts = {
        options = {
          theme = "catppuccin-mocha",
          globalstatus = vim.o.laststatus == 3,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter" } },
        },
        sections = {
          lualine_a = {
            {
              "mode",
              padding = { left = 1, right = 0 },
              separator = { left = "", right = "" },
              color = { fg = mocha.blue, gui = "bold", bg = mocha.base },
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
              separator = { left = "", right = "" },
              padding = { left = 2, right = 0 },
              color = { fg = mocha.yellow, gui = "bold", bg = mocha.base },
            },
          },
          lualine_c = {
            LazyVim.lualine.root_dir(),
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
              separator = { left = "", right = "" },
            },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            -- { LazyVim.lualine.pretty_path() },
            { "filename", path = 0 },
          },
          lualine_x = {
            {
              function()
                return require("noice").api.status.command.get()
              end,
              cond = function()
                return package.loaded["noice"] and require("noice").api.status.command.has()
              end,
              color = function()
                return { fg = Snacks.util.color("Statement") }
              end,
            },
            {
              function()
                return require("noice").api.status.mode.get()
              end,
              cond = function()
                return package.loaded["noice"] and require("noice").api.status.mode.has()
              end,
              color = function()
                return { fg = Snacks.util.color("Constant") }
              end,
            },
            {
              function()
                return "  " .. require("dap").status()
              end,
              cond = function()
                return package.loaded["dap"] and require("dap").status() ~= ""
              end,
              color = function()
                return { fg = Snacks.util.color("Debug") }
              end,
            },
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = function()
                return { fg = Snacks.util.color("Special") }
              end,
            },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
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
          },
          lualine_y = {
            {
              "",
              separator = { left = "", right = "" },
              padding = { left = 0, right = 1 },
              fmt = function()
                return ""
              end,
              color = { fg = mocha.base, bg = mocha.yellow },
            },
            {
              "progress",
              separator = { left = "", right = "" },
              padding = { left = 1, right = 1 },
              color = { fg = mocha.yellow, bg = mocha.base },
            },
            {
              "location",
              padding = { left = 0, right = 1 },
              color = { fg = mocha.yellow, bg = mocha.base },
            },
          },
          lualine_z = {
            {
              "",
              separator = { left = "", right = "" },
              padding = { left = 0, right = 0 },
              color = { fg = mocha.base, bg = mocha.blue },
              fmt = function()
                return "  "
              end,
            },
            {
              function()
                local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
                if #clients == 0 then
                  return ""
                end

                local lspMap = {
                  angularls = "󰚿",
                  lua_ls = "󰢱",
                  eslint = "",
                  vtsls = "",
                  gopls = "",
                  tsserver = "",
                  cssls = "",
                  rustls = "󱘗",
                }

                local names = {}
                for _, client in ipairs(clients) do
                  table.insert(names, lspMap[client.name])
                end

                return table.concat(names, " ")
              end,
              separator = { left = "", right = "" },
              color = { fg = mocha.blue, bg = mocha.base },
            },
          },
        },
        extensions = { "neo-tree", "lazy" },
      }

      return opts
    end,
  },
}
