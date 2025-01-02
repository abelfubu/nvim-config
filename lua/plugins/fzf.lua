return {
  "ibhagwan/fzf-lua",
  opts = {
    fzf_colors = true,
    defaults = {
      formatter = "path.filename_first",
    },
    winopts = {
      preview = {
        hidden = "hidden",
      },
      treesitter = {
        enable = true,
      },
    },
    fzf_args = "--no-header",
  },
}
