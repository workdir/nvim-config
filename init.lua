-- Set <space> as the leader key
-- See `:h mapleader`
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '

-- OPTIONS
--
-- See `:h vim.o`
-- NOTE: You can change these options as you wish!
-- For more options, you can see `:h option-list`
-- To see documentation for an option, you can use `:h 'optionname'`, for example `:h 'number'`
-- (Note the single quotes)

vim.o.number = true -- Show line numbers in a column.

-- Show line numbers relative to where the cursor is.
-- Affects the 'number' option above, see `:h number_relativenumber`.
vim.o.relativenumber = true

-- indentation
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.shiftwidth = 2   -- indentation size when you press >> or auto-indent
vim.opt.tabstop = 2      -- how tabs are displayed
vim.opt.softtabstop = 2  -- how backspace behaves with tabs/spaces
-- vim.opt.smartindent = true    -- basic intelligent indentation | just copy the indent form the line above
-- vim.opt.autoindent = true     -- copy indent from previous line | uses c like syntax

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.cursorline = true -- Highlight the line where the cursor is on.
vim.o.scrolloff = 10    -- Keep this many screen lines above/below the cursor.
vim.o.list = true       -- Show <tab> and trailing spaces.

-- If performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s). See `:h 'confirm'`
vim.o.confirm = true

-- KEYMAPS
--
-- See `:h vim.keymap.set()`, `:h mapping`, `:h keycodes`

-- Use <Esc> to exit terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- Map <A-j>, <A-k>, <A-h>, <A-l> to navigate between windows in any modes
vim.keymap.set({ 't', 'i' }, '<A-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set({ 't', 'i' }, '<A-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set({ 't', 'i' }, '<A-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set({ 't', 'i' }, '<A-l>', '<C-\\><C-n><C-w>l')
vim.keymap.set({ 'n' }, '<A-h>', '<C-w>h')
vim.keymap.set({ 'n' }, '<A-j>', '<C-w>j')
vim.keymap.set({ 'n' }, '<A-k>', '<C-w>k')
vim.keymap.set({ 'n' }, '<A-l>', '<C-w>l')

-- clipboard
vim.g.loaded_clipboard_provider = 1 -- disable clipboard provider entirely

vim.keymap.set({ 'n', 'v' }, '<leader>c', function()
  vim.fn.system('clip.exe', vim.fn.getreg('"'))
end)

-- print message

-- AUTOCOMMANDS (EVENT HANDLERS)
--
-- See `:h lua-guide-autocommands`, `:h autocmd`, `:h nvim_create_autocmd()`

-- Highlight when yanking (copying) text.
-- Try it with `yap` in normal mode. See `:h vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.hl.on_yank()
  end,
})

-- USER COMMANDS: DEFINE CUSTOM COMMANDS
--
-- See `:h nvim_create_user_command()` and `:h user-commands`

-- Create a command `:GitBlameLine` that print the git blame for the current line
vim.api.nvim_create_user_command('GitBlameLine', function()
  local line_number = vim.fn.line('.') -- Get the current line number. See `:h line()`
  local filename = vim.api.nvim_buf_get_name(0)
  print(vim.system({ 'git', 'blame', '-L', line_number .. ',+1', filename }):wait().stdout)
end, { desc = 'Print the git blame for the current line' })

-- PLUGINS
--
-- See `:h :packadd`, `:h vim.pack`

-- Add the "nohlsearch" package to automatically disable search highlighting after
-- 'updatetime' and when going to insert mode.
vim.cmd('packadd! nohlsearch')

-- Install third-party plugins via "vim.pack.add()".
vim.pack.add({
  -- Quickstart configs for LSP
  'https://github.com/neovim/nvim-lspconfig',
  -- Fuzzy picker
  'https://github.com/ibhagwan/fzf-lua',
  -- Autocompletion
  'https://github.com/nvim-mini/mini.completion',
  -- Enhanced quickfix/loclist
  'https://github.com/stevearc/quicker.nvim',
  -- Git integration
  'https://github.com/lewis6991/gitsigns.nvim',
  -- Treesitter
  {
    src = 'https://github.com/nvim-treesitter/nvim-treesitter',
    version = 'main',
  },
  -- Treesitter-textobjects
  {
    src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
    version = 'main'
  },
  -- Mason Language Servers
  'https://github.com/mason-org/mason.nvim',
  -- Language Servers Config
  'https://github.com/neovim/nvim-lspconfig',
  -- Colorscheme
  'https://github.com/nyoom-engineering/oxocarbon.nvim'
})

require('fzf-lua').setup { fzf_colors = true }
require('mini.completion').setup {}
require('quicker').setup {}
require('gitsigns').setup {}
require('mason').setup {}

local ts_languages = {
  'lua',
  'json',
  'markdown',
  'query',
  'typescript'
}

for _, lang in ipairs(ts_languages) do
  vim.g['no_' .. lang .. '_maps'] = true
end

require('nvim-treesitter').setup {}
require('nvim-treesitter').install(ts_languages)

vim.api.nvim_create_autocmd('FileType', {
  pattern = ts_languages,
  callback = function()
    vim.treesitter.start()
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

require('nvim-treesitter-textobjects').setup({
  select = {
    lookahead = true
  }
})

-- local ts_repeat_move = require "nvim-treesitter-textobjects.repeatable_move"

-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

-- function
vim.keymap.set({ "x", "o" }, "af", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "if", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
end)

vim.keymap.set({ "n", "x", "o" }, "<leader>af", function()
  require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "<leader>aF", function()
  require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
end)

-- class
vim.keymap.set({ "x", "o" }, "ac", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@class.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ic", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@class.inner", "textobjects")
end)

-- arugment/parameter
vim.keymap.set({ "x", "o" }, "aa", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@parameter.outer", "textobjects")
end, { desc = "Select around a parameter/argument" })
vim.keymap.set({ "x", "o" }, "ia", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@parameter.inner", "textobjects")
end, { desc = "Select inside a parameter/argument" })

-- conditional
vim.keymap.set({ "x", "o" }, "ai", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@conditional.outer", "textobjects")
end, { desc = "Select around a conditional" })
vim.keymap.set({ "x", "o" }, "ii", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@conditional.inner", "textobjects")
end, { desc = "Select inside a conditional" })

-- loop
vim.keymap.set({ "x", "o" }, "al", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@loop.outer", "textobjects")
end, { desc = "Select around a loop" })
vim.keymap.set({ "x", "o" }, "il", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@loop.inner", "textobjects")
end, { desc = "Select inside a loop" })

-- comment
vim.keymap.set({ "x", "o" }, "ao", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@comment.outer", "textobjects")
end, { desc = "Select around a comment" })
vim.keymap.set({ "x", "o" }, "io", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@comment.inner", "textobjects")
end, { desc = "Select inside a comment" })

-- assignment.lhs | rhs
vim.keymap.set({ "x", "o" }, "am", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@assignment.lhs", "textobjects")
end, { desc = "Select left-hand side of assignment" })
vim.keymap.set({ "x", "o" }, "ah", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@assignment.rhs", "textobjects")
end, { desc = "Select right-hand side of assignment" })

-- attribute
vim.keymap.set({ "x", "o" }, "at", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@attribute.outer", "textobjects")
end, { desc = "Select around an attribute" })
vim.keymap.set({ "x", "o" }, "it", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@attribute.inner", "textobjects")
end, { desc = "Select inside an attribute" })

-- block
vim.keymap.set({ "x", "o" }, "ab", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@block.outer", "textobjects")
end, { desc = "Select around a block" })
vim.keymap.set({ "x", "o" }, "ib", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@block.inner", "textobjects")
end, { desc = "Select inside a block" })

-- call
vim.keymap.set({ "x", "o" }, "ak", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@call.outer", "textobjects")
end, { desc = "Select around a function call" })
vim.keymap.set({ "x", "o" }, "ik", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@call.inner", "textobjects")
end, { desc = "Select inside a function call" })

-- regex
vim.keymap.set({ "x", "o" }, "ax", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@regex.outer", "textobjects")
end, { desc = "Select around a regex" })
vim.keymap.set({ "x", "o" }, "ix", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@regex.inner", "textobjects")
end, { desc = "Select inside a regex" })

-- return
vim.keymap.set({ "x", "o" }, "ar", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@return.outer", "textobjects")
end, { desc = "Select around a return statement" })
vim.keymap.set({ "x", "o" }, "ir", function()
  require("nvim-treesitter-textobjects.select").select_textobject("@return.inner", "textobjects")
end, { desc = "Select inside a return statement" })

vim.keymap.set({ "x", "o" }, "as", function()
  require "nvim-treesitter-textobjects.select".select_textobject("@local.scope", "locals")
end)

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
       diagnostics = {
        globals = { "vim" },
      },
      -- workspace = { it is just fucking slow
      --    library = {
      --       vim.env.VIMRUNTIME,
      --    },
      --   checkThirdParty = false,
      -- },
    },
  },
})

vim.lsp.enable({ 'lua_ls', 'vtsls', 'jsonls' })

vim.opt.background = "dark" -- set this to dark or light
vim.cmd.colorscheme "oxocarbon"
