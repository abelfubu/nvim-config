return {
  "goolord/alpha-nvim",
  opts = function(_, opts)
    local logos = require("logos")
    local header = require("utils").apply_gradient_hl("#abe9b3", "#89b4fa", logos.neovim)
    opts.section.header.type = header.type
    opts.section.header.opts = header.opts
    opts.section.header.val = header.val
  end,
}
