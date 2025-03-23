vim.api.nvim_create_user_command("AzureItems", function()
  require("azure.commands.list-work-items").list_work_items()
end, { nargs = 0, force = true })

vim.api.nvim_create_user_command("AzurePullRequests", function()
  require("azure.commands.list-pull-requests").list_pull_requests()
end, { nargs = 0, force = true })

vim.api.nvim_create_user_command("AzureCreatePR", function()
  coroutine.wrap(function()
    require("azure.commands.create-pull-request").azure_create_pr()
  end)()
end, { nargs = 0, force = true })

vim.keymap.set("n", "<leader>wa", "<cmd>AzureItems<cr>")
vim.keymap.set("n", "<leader>wp", "<cmd>AzurePullRequests<cr>")
vim.keymap.set("n", "<leader>wn", "<cmd>AzureCreatePR<cr>")
