-- -- Avoids Esc+arrows to move lines
vim.opt.timeoutlen = 300
vim.opt.ttimeoutlen = 0
vim.opt.list = false
vim.g.snacks_animate = false

if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
  vim.o.shell = "pwsh" -- Use PowerShell as the default shell
  vim.o.shellcmdflag = "-NoLogo -ExecutionPolicy RemoteSigned -Command"
  vim.o.shellquote = ""
  vim.o.shellxquote = ""
end