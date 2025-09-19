-- Only applies to Java files
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = true -- use spaces instead of tabs

-- Simple run keymap for standalone Java files (nvim-java handles project files)
vim.keymap.set('n', '<leader>r', ':!javac % && java %:r<CR>', { buffer = true, desc = '[R]un Java file' })

-- Additional Java-specific settings
vim.opt_local.colorcolumn = '120' -- Java convention line length
vim.opt_local.textwidth = 120
