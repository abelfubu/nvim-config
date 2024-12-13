require("config.lazy")

local fzf = require("fzf-lua")

local function execute_command(command)
  local handle = io.popen(command, "r")
  if not handle then
    error("Failed to execute command: " .. command)
  end
  local result = handle:read("*a")
  handle:close()
  if not result or result == "" then
    return nil, "Command returned empty output"
  end
  local ok, decoded = pcall(vim.json.decode, result)
  if not ok then
    return nil, "Failed to decode JSON: " .. decoded
  end
  return decoded
end

local function strip_html_tags(html)
  return html:gsub("<[^>]+>", ""):gsub("&nbsp;", " "):gsub("&lt;", "<"):gsub("&gt;", ">"):gsub("&amp;", "&")
end

local function get_all_items()
  local command = [[
    az boards query --wiql "
    SELECT [System.Id], [System.Title], [System.State], [System.WorkItemType], [Assigned To], [System.Description]
    FROM WorkItems 
    WHERE [System.WorkItemType] IN ('Task', 'User Story', 'Bug', 'Defect') 
    AND [System.ChangedDate] >= @Today - 30 
    ORDER BY [System.ID] DESC"
  ]]
  local result, err = execute_command(command)
  if not result then
    error("Error fetching items: " .. err)
  end
  print(result)
  return result
end

local function open_fzf_picker(results)
  local items = {}
  for _, item in ipairs(results) do
    -- Generate display strings and corresponding URLs
    local display = string.format(
      "[%s] %s (%s) : [%s]",
      item.fields["System.Id"],
      item.fields["System.Title"],
      item.fields["System.State"],
      item.fields["System.AssignedTo"] and item.fields["System.AssignedTo"]["displayName"] or "Unassigned"
    )
    local url = string.format(item.url)
    table.insert(
      items,
      { display = display, url = url, preview = strip_html_tags(item.fields["System.Description"] or "No description") }
    )
  end

  -- Pass items to FZF picker
  fzf.fzf_exec(
    vim.tbl_map(function(item)
      return item.display
    end, items),
    {
      prompt = " Work Items > ",
      preview = function(selected, _)
        local selected_item = nil

        for _, item in ipairs(items) do
          if item.display == selected[1] then
            selected_item = item
            break
          end
        end

        if selected_item and selected_item.preview then
          return selected_item.preview -- Show raw Markdown content
        else
          return "No details available"
        end
      end,
      actions = {
        ["default"] = function(selected)
          -- Find the corresponding item from the original list
          local selected_item = nil

          for _, item in ipairs(items) do
            if item.display == selected[1] then
              selected_item = item
              break
            end
          end

          if selected_item and selected_item.url then
            -- Open the URL in the default web browser
            os.execute(string.format("xdg-open '%s'", selected_item.url)) -- Use `xdg-open` for Linux
            -- os.execute(string.format("open '%s'", selected_item.url)) -- Use `open` for macOS
            print(selected_item.url)
            -- os.execute(string.format("start '%s'", selected_item.url)) -- Use `start` for Windows
          else
            print("No URL found for the selected item")
          end
        end,
      },
    }
  )
end

local function fetch_and_display_items()
  local success, results = pcall(get_all_items) -- Assume `get_all_items` fetches the Azure Boards results
  if success then
    open_fzf_picker(results)
  else
    print("Error fetching items: " .. results)
  end
end

vim.keymap.set("n", "<space><space>x", fetch_and_display_items)
