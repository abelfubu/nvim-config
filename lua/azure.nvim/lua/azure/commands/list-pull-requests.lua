local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local previewers = require("telescope.previewers")
local utils = require("telescope.previewers.utils")

local M = {}

function M.list_pull_requests(opts)
  local cwd = vim.fn.getcwd():match(".*/(.-)$")
  local command = string.format("az repos pr list -p NewPOL -o json -r %s", cwd)
  local result, error = require("azure.utils.cmd").execute_command(command)

  print(vim.inspect(opts))

  if not result then
    print(error)
    return
  end

  pickers
    .new(opts, {
      prompt_title = "Pull Request",
      finder = finders.new_table({
        results = result,
        entry_maker = function(entry)
          local formatted =
            string.format("[%s] %s %s %s", entry.pullRequestId, entry.title, entry.status, entry.createdBy.displayName)
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
          local repo = vim.fn.getcwd():match(".*/(.-)$")

          actions.close(prompt_bufnr)

          local config = require("azure").config

          local url = string.format("%s/%s/_git/%s/pullrequest", config.domain, config.project, repo)

          os.execute(string.format("xdg-open %s/%s", url, selection.value.pullRequestId))
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
          local item = entry.value

          local preview_lines = {
            string.format("[%s]", item.pullRequestId),
            string.format("# %s", item.title),
            string.format(" %s", item.creationDate:sub(0, 10)),
            string.format("󱖫 %s", item.status),
            string.format(" %s", item.createdBy.displayName),
            "",
          }

          if item.description and item.description ~= vim.NIL then
            local description = require("azure.utils.parsers.html-parser").parse_html(item.description or "")

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
