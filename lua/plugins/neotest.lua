return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "haydenmeade/neotest-jest",
      "marilari88/neotest-vitest",
    },
    opts = function(_, opts)
      table.insert(
        opts.adapters,
        require("neotest-jest")({
          -- jestCommand = function(path)
          --   return "npx jest --  --json --forceExit --detectOpenHandles " .. path:gsub("\\", "/")
          -- end,
          -- discovery = {
          --   enabled = false,
          -- },
          -- env = { CI = true },
          -- cwd = function()
          --   return vim.fn.getcwd():gsub("\\", "/")
          -- end,
        })
      )
      table.insert(opts.adapters, require("neotest-vitest"))
    end,
  },
}
