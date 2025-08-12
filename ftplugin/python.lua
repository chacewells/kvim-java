-- Python-specific configuration
-- Set Python-specific indentation (following PEP 8)
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = true

-- Python-specific keymaps
vim.keymap.set('n', '<leader>r', ':!python3 %<CR>', { buffer = true, desc = '[R]un Python file' })

-- Auto-format on save (optional, can be removed if you prefer manual formatting)
vim.api.nvim_create_autocmd('BufWritePre', {
  buffer = 0,
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- Set Python-specific options
vim.opt_local.colorcolumn = '88' -- Black's default line length
vim.opt_local.textwidth = 88

-- Python-specific text objects and motions
-- You can add more Python-specific configurations here as needed
