local Job = require("plenary.job")
local builtin = require("fzf-lua.previewer.builtin")

local M = {}

local cancel_current_job = nil

local function fetch_data(package, callback)
  ---@diagnostic disable-next-line: missing-fields
  local job = Job:new({
    command = "curl",
    args = { "-s", "https://registry.npmjs.org/-/v1/search?text=" .. package },
    on_exit = function(j, return_val)
      if return_val == 0 then
        callback(table.concat(j:result(), "\n"))
      else
        callback(nil, table.concat(j:stderr_result(), "\n"))
      end
    end,
  })

  job:start()

  return function()
    job:shutdown()
  end
end

M.get_package_json = function()
  local cwd = vim.fn.getcwd()
  local file_path = string.format("%s/package.json", cwd)
  local file = io.open(file_path, "r")

  if not file then
    error("Could not open package.json file")
  end

  local content = file:read("*a")
  file:close()

  local data = vim.json.decode(content)

  local deps = {}

  for k, v in pairs(data.dependencies or {}) do
    deps[k] = v
  end

  for k, v in pairs(data.devDependencies or {}) do
    deps[k] = v
  end

  return deps
end

local MyPreviewer = builtin.base:extend()

function MyPreviewer:new(o, opts, fzf_win)
  MyPreviewer.super.new(self, o, opts, fzf_win)
  setmetatable(self, MyPreviewer)
  return self
end

function MyPreviewer:populate_preview_buf(entry_str)
  local tmpbuf = self:get_tmp_buffer()

  if cancel_current_job then
    cancel_current_job()
    cancel_current_job = nil
  end

  local entry = vim.split(entry_str, " ")

  cancel_current_job = fetch_data(entry[1], function(result, err)
    vim.schedule(function()
      if result then
        local package = vim.json.decode(result).objects[1].package

        vim.api.nvim_buf_set_lines(tmpbuf, 0, -1, false, {
          "[ctrl-i] install new version | [ctrl-f] force install new version",
          "",
          "# " .. string.upper(package.name),
          "",
          package.description,
          "LICENSE: " .. package.license,
          "CURRENT VERSION: " .. entry[#entry],
          "LAST VERSION: " .. package.version,
          "LAST UPDATE: " .. package.date:sub(0, 10),
        })
        vim.bo[tmpbuf].filetype = "markdown"
        self:set_preview_buf(tmpbuf)
        self.win:update_scrollbar()
      else
        vim.api.nvim_buf_set_lines(tmpbuf, 0, -1, false, { err })
      end
    end)
  end)
end

function MyPreviewer:gen_winopts()
  local new_winopts = {
    wrap = false,
    number = false,
  }
  return vim.tbl_extend("force", self.winopts, new_winopts)
end

local function fuzzy_npm_search()
  local fzf_lua = require("fzf-lua")

  local opts = {
    actions = {
      ["default"] = function(selected)
        local package = selected[1]:match("^[^%s]+")
        os.execute("start https://www.npmjs.com/package/" .. package)
      end,
      ["ctrl-i"] = function(selected)
        print(vim.inspect(selected))
      end,
    },
    previewer = MyPreviewer,
  }

  fzf_lua.fzf_exec(function(cb)
    local packages = M.get_package_json()
    for package, version in pairs(packages) do
      cb(string.format("%-37s %s", package:sub(0, 36), version))
    end
    cb()
  end, opts)
end

vim.keymap.set("n", "<leader>np", fuzzy_npm_search, { noremap = true, silent = true, desc = "Npm list packages" })

return {}
