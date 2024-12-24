local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local previewers = require("telescope.previewers")
local utils = require("telescope.previewers.utils")

local M = {}

function M.list_work_items(opts)
  local teams_list = table.concat(
    vim.tbl_map(function(team)
      return string.format("'%s'", team)
    end, require("azure").config.nodeNames),
    ", "
  )

  local query = string.format(
    [[
      az boards query -o json --wiql "
      SELECT *
      FROM WorkItems
      WHERE [System.ChangedDate] >= @Today - 30
      AND [System.NodeName] IN (%s)
      AND [System.WorkItemType] IN ('Task', 'User Story', 'Bug', 'Defect')"
   ]],
    teams_list
  )

  local result, error = require("azure.utils.cmd").execute_command(query)

  if not result then
    print("ERROR", error)
    return
  end

  pickers
    .new(opts, {
      preview = {
        hide_on_startup = true,
      },
      prompt_title = "Work Item",
      finder = finders.new_table({
        results = result,
        entry_maker = function(entry)
          local item = entry.fields

          local formatted = string.format(
            "%s %s %s %s %s",
            item["System.Id"],
            item["System.Title"],
            item["System.State"],
            item["System.AssignedTo"] and item["System.AssignedTo"]["displayName"] or "Not Assigned",
            item["System.NodeName"]
          )
          return {
            value = entry,
            display = formatted,
            ordinal = formatted,
          }
        end,
      }),
      sorter = sorters.get_fzy_sorter(opts),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()

          actions.close(prompt_bufnr)

          local item, failed = require("azure.utils.cmd").execute_command(
            string.format(
              'az boards work-item show --id %s --query "url" -o json',
              selection.value["fields"]["System.Id"]
            )
          )

          if not result then
            print(failed)
          end

          os.execute(string.format("xdg-open '%s'", item:gsub("apis/wit/workItems", "workitems/edit")))
        end)

        map("i", "<C-y>", function()
          local selection = action_state.get_selected_entry()
          local id = selection.value["fields"]["System.Id"]

          vim.fn.setreg("+", id)
          vim.fn.setreg("*", id)

          actions.close(prompt_bufnr)
          print("Copied Task ID to clipboard:", id)
        end)

        return true
      end,
      previewer = previewers.new_buffer_previewer({
        title = "Preview",
        define_preview = function(self, entry)
          local item = entry.value["fields"]

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
            string.format(
              " %s",
              item["System.AssignedTo"] and item["System.AssignedTo"]["displayName"] or "Not Assigned"
            ),
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

          vim.api.nvim_buf_set_lines(self.state.bufnr, 0, 0, true, preview_lines)

          utils.highlighter(self.state.bufnr, "markdown")
        end,
      }),
    })
    :find()
end

return M
