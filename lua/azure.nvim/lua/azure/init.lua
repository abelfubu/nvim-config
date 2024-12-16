local M = {}

M.config = {
  project = "NewPOL",
  domain = "https://wkeuds.visualstudio.com",
}

M.setup = function(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

return M
