return {
  "nyoom-engineering/oxocarbon.nvim",
  config = function()
    vim.opt.background = "dark"
    vim.cmd.colorscheme("oxocarbon") -- a comment
    vim.api.nvim_set_hl(0, "Comment", { fg = "#7eb6d4", italic = true })
  end,
}
