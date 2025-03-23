local M = {}

local work_items = {}

function M.list_work_items()
  local teams_list = table.concat(
    vim.tbl_map(function(team)
      return string.format("'%s'", team)
    end, require("azure").config.nodeNames),
    ", "
  )

  local query = string.format(
    [[ az boards query -o json --wiql "SELECT * FROM WorkItems WHERE [System.ChangedDate] >= @Today - 30 AND [System.NodeName] IN (%s) AND [System.WorkItemType] IN ('Task', 'User Story', 'Bug', 'Defect')" ]],
    teams_list
  )

  local MyPreviewer = require("fzf-lua.previewer.builtin").base:extend()

  function MyPreviewer:new(o, opts, fzf_win)
    MyPreviewer.super.new(self, o, opts, fzf_win)
    setmetatable(self, MyPreviewer)
    return self
  end

  function MyPreviewer:populate_preview_buf(selection)
    local tmpbuf = self:get_tmp_buffer()
    local found = nil

    for _, entry in ipairs(work_items) do
      if string.format("%d", entry.fields["System.Id"]) == selection:sub(0, 6) then
        found = entry
        break
      end
    end

    if not found then
      return "No preview available"
    end

    local item = found["fields"]

    local item_types = {
      Bug = "",
      Task = "",
      ["Product Backlog Item"] = "󰏖",
      Feature = "",
    }

    local preview_lines = {
      string.format("[%s]", item["System.Id"]),
      string.format("# %s", string.upper(item["System.Title"])),
      string.format(" %s", item["System.ChangedDate"]:sub(0, 10)),
      string.format("󱖫 %s", item["System.State"]),
      string.format(" %s", item["System.AssignedTo"] and item["System.AssignedTo"]["displayName"] or "Not Assigned"),
      string.format(" %s", item["System.NodeName"]),
      string.format("%s %s", item_types[item["System.WorkItemType"]] or "", item["System.WorkItemType"]),
      item["System.Tags"] and string.format(" %s", item["System.Tags"] or "") or "",
      "",
    }

    if item["System.Description"] then
      local description = require("azure.utils.parsers.html-parser").parse_html(item["System.Description"] or "")

      for _, value in ipairs(vim.split(description or "", "\n")) do
        table.insert(preview_lines, value)
      end
    end

    vim.api.nvim_buf_set_lines(tmpbuf, 0, -1, false, preview_lines)
    vim.bo[tmpbuf].filetype = "markdown"
    self:set_preview_buf(tmpbuf)
    self.win:update_scrollbar()
  end

  function MyPreviewer:gen_winopts()
    local new_winopts = {
      wrap = false,
      number = false,
    }
    return vim.tbl_extend("force", self.winopts, new_winopts)
  end

  require("fzf-lua").fzf_exec(function(callback)
    local result, error = require("azure.utils.cmd").execute_command(query)

    if not result then
      print("ERROR", error)
      return
    end

    work_items = result

    for _, entry in ipairs(result) do
      local item = entry.fields

      local formatted = string.format(
        "%s %s %s %s %s",
        item["System.Id"],
        item["System.Title"],
        item["System.State"],
        item["System.AssignedTo"] and item["System.AssignedTo"]["displayName"] or "Not Assigned",
        item["System.NodeName"]
      )
      callback(formatted)
    end

    callback()
  end, {
    prompt = "Work Item> ",
    actions = {
      ["default"] = function(selected)
        local item, failed = require("azure.utils.cmd").execute_command(
          string.format('az boards work-item show --id %s --query "url" -o json', selected[1]:sub(0, 6))
        )

        if not item then
          print(failed)
        end

        vim.ui.open(item:gsub("apis/wit/workItems", "workitems/edit"))
      end,

      ["ctrl-y"] = function(selected)
        local id = selected[1]:sub(0, 6)

        vim.fn.setreg("+", id)
        vim.fn.setreg("*", id)

        print("Copied Task ID to clipboard:", id)
      end,
    },
    previewer = MyPreviewer,
  })
end

return M
