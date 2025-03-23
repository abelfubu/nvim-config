local M = {}

local current_job_id = nil

function M.list_pull_requests()
  local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  local command = string.format("az repos pr list -p %s -o json -r %s", require("azure").config.project, cwd)
  local result, error = require("azure.utils.cmd").execute_command(command)

  if not result then
    print(error)
    return
  end

  local MyPreviewer = require("fzf-lua.previewer.builtin").base:extend()

  function MyPreviewer:new(o, opts, fzf_win)
    MyPreviewer.super.new(self, o, opts, fzf_win)
    setmetatable(self, MyPreviewer)
    return self
  end

  function MyPreviewer:populate_preview_buf(selection)
    local tmpbuf = self:get_tmp_buffer()
    local found = nil

    for _, entry in ipairs(result) do
      if tostring(entry.pullRequestId) == selection:sub(2, 6) then
        found = entry
        break
      end
    end

    if not found then
      vim.api.nvim_buf_set_lines(tmpbuf, 0, 0, true, { "No result available" })

      vim.bo[tmpbuf].filetype = "markdown"

      return
    end

    if current_job_id ~= nil then
      vim.fn.jobstop(current_job_id)
      current_job_id = nil
    end

    local preview_lines = {
      string.format("[%s]", found.pullRequestId),
      string.format("# %s", string.upper(found.title)),
      string.format(" %s", found.creationDate:sub(0, 10)),
      string.format(" %s", found.createdBy.displayName),
      string.format(" %s", found.sourceRefName),
      "### Reviewers",
    }

    for _, value in ipairs(found.reviewers) do
      table.insert(preview_lines, string.format(" %s", value.displayName))
    end

    if found.description and found.description ~= vim.NIL then
      table.insert(preview_lines, "")
      table.insert(preview_lines, "### Description")
      local description = require("azure.utils.parsers.html-parser").parse_html(found.description or "")

      for _, value in ipairs(vim.split(description or "", "\n")) do
        table.insert(preview_lines, value)
      end
    end

    vim.api.nvim_buf_set_lines(tmpbuf, 0, -1, false, preview_lines)

    vim.bo[tmpbuf].filetype = "markdown"
    self:set_preview_buf(tmpbuf)
    self.win:update_scrollbar()

    current_job_id = vim.fn.jobstart(
      string.format(
        "az pipelines runs list %s",
        table.concat(
          { "-p", require("azure").config.project, "--branch", "refs/pull/" .. found.pullRequestId .. "/merge" },
          " "
        )
      ),
      {
        stdout_buffered = true,
        stderr_buffered = true,
        on_stdout = function(_, data, _)
          if data and #data > 0 then
            local json = table.concat(data, "\n")
            local ok, pipeline_runs = pcall(vim.json.decode, json)

            if ok and next(pipeline_runs) ~= nil then
              local pipeline_result = true

              for _, value in ipairs(pipeline_runs) do
                if value.result == "failed" then
                  pipeline_result = false
                  break
                end
              end

              vim.schedule(function()
                local current_line_count = vim.api.nvim_buf_line_count(tmpbuf)

                vim.api.nvim_buf_set_lines(tmpbuf, current_line_count, current_line_count, true, {
                  "",
                  string.format(
                    "### %s: %s",
                    pipeline_runs[1].definition.name,
                    pipeline_result and "Succeeded" or "Failed"
                  ),
                })

                vim.bo[tmpbuf].filetype = "markdown"
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
  end

  function MyPreviewer:gen_winopts()
    local new_winopts = {
      wrap = false,
      number = false,
    }

    return vim.tbl_extend("force", self.winopts, new_winopts)
  end

  require("fzf-lua").fzf_exec(function(callback)
    for _, entry in ipairs(result) do
      local formatted =
        string.format("[%s] %s %s %s", entry.pullRequestId, entry.title, entry.status, entry.createdBy.displayName)

      callback(formatted)
    end

    callback()
  end, {
    actions = {
      ["default"] = function(selected)
        local repo = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
        local config = require("azure").config
        local url = string.format("%s/%s/_git/%s/pullrequest", config.domain, config.project, repo)
        vim.ui.open(string.format("%s/%s", url, selected[1]:sub(2, 6)))
      end,
      ["ctrl-y"] = function(selected)
        local id = selected[1]:sub(2, 6)

        vim.fn.setreg("+", id)
        vim.fn.setreg("*", id)

        print("Copied Task ID to clipboard:", id)
      end,
      ["ctrl-b"] = function(selected)
        local id = selected[1]:sub(2, 6)

        for _, pull_request in ipairs(result) do
          print(vim.inspect(pull_request), id)
          if pull_request.pullRequestId == tonumber(id) then
            local branch = pull_request["sourceRefName"]
            vim.fn.setreg("+", branch)
            vim.fn.setreg("*", branch)

            print("Copied Git Branch to clipboard:", branch)
            break
          end
        end
      end,
    },
    previewer = MyPreviewer,
  })
end

return M
