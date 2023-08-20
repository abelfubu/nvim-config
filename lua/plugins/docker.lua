return {
  {
    "https://codeberg.org/esensar/nvim-dev-container",
    opts = {
      attach_mounts = {
        always = true,
        neovim_config = {
          enabled = true,
          options = { "readonly" },
        },
        neovim_data = {
          enabled = false,
          options = {},
        },
        neovim_state = {
          enabled = false,
          options = {},
        },
      },
    },
  },
}
