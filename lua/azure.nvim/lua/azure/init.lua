local M = {}

M.config = {
  project = "NewPOL",
  domain = "https://wkeuds.visualstudio.com",
  nodeNames = { "Krypton Team", "Atalaya Team", "Eternia Team", "Castillo Grayskull", "Estación Zeta" },
}

M.setup = function(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

return M
