vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

vim.opt.wrap = true
vim.opt.breakindent = true

vim.opt.inccommand = 'split'

vim.opt.mouse = 'a'

vim.opt.showmode = false

vim.opt.undofile = true

vim.opt.inccommand = 'split'

vim.opt.cursorline = true

vim.opt.scrolloff = 10

vim.opt.winborder = 'rounded'

vim.opt.signcolumn = "yes"

vim.opt.number = true

vim.opt.relativenumber = true

vim.opt.fillchars = { eob = " " }

-- vim.opt.linebreak = true

vim.opt.smartindent = true

vim.opt.mouse = "a"

vim.opt.clipboard = "unnamedplus"


-- works only upon lua files which is not satisfiable
-- vim.opt.formatoptions = vim.opt.formatoptions - { 'o', 'r' } + { 'j' }
