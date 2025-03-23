local map = vim.keymap.set

map("n", "<C-p>", Snacks.picker.files, { desc = "Go to Left Window", remap = true })
map("i", "<C-l>", "<Esc><C-w>l")
map("i", "<C-h>", "<Esc><C-w>h")

-- stylua: ignore
map("n", "<leader>al", function() Snacks.terminal.open("lazyazz") end, { desc = "LazyAzz" })
map("n", "<C-q>", "<CMD>wqa<CR>", { desc = "Write and Quit all" })
