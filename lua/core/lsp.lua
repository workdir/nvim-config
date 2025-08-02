vim.lsp.enable({"lua_ls", "ts_ls"})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
      vim.keymap.set('i', '<C-Space>', function()
        vim.lsp.completion.get()
      end)
    end
  end,
})

vim.cmd("set completeopt+=noselect")

vim.diagnostic.config({
  -- Use the default configuration
  -- virtual_lines = {
  --  current_line = true,
  -- },

  -- signs = true,
  -- underline = true,

  -- Alternatively, customize specific options
  -- virtual_lines = {
  --  -- Only show virtual line diagnostics for the current cursor line
  --  current_line = true,
  -- },
  virtual_lines = false, -- disable virtual lines if you prefer
  virtual_text = false,  -- disable virtual text if it's too cluttered
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = true,
    header = "",
    prefix = "",
    wrap = true,  -- This ensures that the diagnostic message wraps instead of overflowing
  },
})

