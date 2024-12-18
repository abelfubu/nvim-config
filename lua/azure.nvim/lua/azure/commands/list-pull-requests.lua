local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local previewers = require("telescope.previewers")
local utils = require("telescope.previewers.utils")

local M = {}

local current_job_id = nil

function M.list_pull_requests(opts)
  local cwd = vim.fn.getcwd():match(".*/(.-)$")
  local command = string.format("az repos pr list -p %s -o json -r %s", require("azure").config.project, cwd)
  local result, error = require("azure.utils.cmd").execute_command(command)

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
      sorter = sorters.get_generic_fuzzy_sorter(opts),
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

        map("i", "<C-b>", function()
          local selection = action_state.get_selected_entry()
          local branch = selection.value["sourceRefName"]

          vim.fn.setreg("+", branch)
          vim.fn.setreg("*", branch)

          actions.close(prompt_bufnr)
          print("Copied Git Branch to clipboard:", branch)
        end)

        return true
      end,
      previewer = previewers.new_buffer_previewer({
        title = "Preview",
        define_preview = function(self, entry)
          if current_job_id ~= nil then
            vim.fn.jobstop(current_job_id)
            current_job_id = nil
          end

          local item = entry.value

          local preview_lines = {
            string.format("[%s]", item.pullRequestId),
            string.format("# %s", string.upper(item.title)),
            string.format(" %s", item.creationDate:sub(0, 10)),
            string.format(" %s", item.createdBy.displayName),
            string.format(" %s", item.sourceRefName),
            "### Reviewers",
          }

          for _, value in ipairs(item.reviewers) do
            table.insert(preview_lines, string.format(" %s", value.displayName))
          end

          if item.description and item.description ~= vim.NIL then
            table.insert(preview_lines, "")
            table.insert(preview_lines, "### Description")
            local description = require("azure.utils.parsers.html-parser").parse_html(item.description or "")

            for _, value in ipairs(vim.split(description or "", "\n")) do
              table.insert(preview_lines, value)
            end
          end

          vim.api.nvim_buf_set_lines(self.state.bufnr, 0, 0, true, preview_lines)

          utils.highlighter(self.state.bufnr, "markdown")

          current_job_id = vim.fn.jobstart(
            string.format(
              "az pipelines runs list %s",
              table.concat(
                { "-p", require("azure").config.project, "--branch", "refs/pull/" .. item.pullRequestId .. "/merge" },
                " "
              )
            ),
            {
              stdout_buffered = true,
              stderr_buffered = true,
              on_stdout = function(_, data, _)
                if data and #data > 0 then
                  local json = table.concat(data, "\n")
                  local ok, pipeline_runs = pcall(vim.fn.json_decode, json)

                  if ok and next(pipeline_runs) ~= nil then
                    local pipeline_result = true

                    for _, value in ipairs(pipeline_runs) do
                      if value.result == "failed" then
                        pipeline_result = false
                        break
                      end
                    end

                    vim.schedule(function()
                      vim.api.nvim_buf_set_lines(self.state.bufnr, #preview_lines + 1, #preview_lines + 1, true, {
                        string.format(
                          "### %s: %s",
                          pipeline_runs[1].definition.name,
                          pipeline_result and "Succeeded" or "Failed"
                        ),
                      })

                      utils.highlighter(self.state.bufnr, "markdown")
                    end)
                  end
                end
              end,
              on_stderr = function(_, data, _)
                if data and next(data) ~= nil and data[1] ~= "" then
                  print("STDERR:", vim.inspect(data))
                end
              end,
              on_exit = function(_, code, _)
                if code ~= 0 then
                  print("Azure CLI command failed with code:", code)
                end
              end,
            }
          )
        end,
      }),
    })
    :find()
end

return M
