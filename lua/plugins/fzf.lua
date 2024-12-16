return {
  {
    "ibhagwan/fzf-lua",
    enabled = false,
    opts = {
      defaults = {
        formatter = "path.filename_first",
        -- formatter = "path.dirname_first",
      },
      winopts = {
        -- fullscreen = true,
        preview = {
          hidden = "hidden",
        },
      },
      files = {
        -- path_shorten = 1,
      },
      fzf_args = "--no-header",
    },
  },
}
