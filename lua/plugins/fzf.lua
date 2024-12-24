return {
  "ibhagwan/fzf-lua",
  opts = {
    defaults = {
      formatter = "path.filename_first",
    },
    winopts = {
      preview = {
        hidden = "hidden",
      },
    },
    fzf_args = "--no-header",
  },
}
