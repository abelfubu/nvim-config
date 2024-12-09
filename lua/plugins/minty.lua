return {
  {
    "nvzone/minty",
    dependencies = { "nvzone/volt", lazy = true },
    cmd = { "Shades", "Huefy" },
    opts = {
      huefy = { border = true },
    },
    keys = {
      {
        "<leader>zt",
        function()
          require("minty.huefy").open()
        end,
        { description = "Minty" },
      },
    },
  },
}
