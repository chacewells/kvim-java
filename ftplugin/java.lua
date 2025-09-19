-- Only applies to Java files
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.keymap.set('n', '<leader>r', ':!javac % && java %:r<CR>', { buffer = true })

-- Set indentation for Java files
vim.bo.expandtab = true -- use spaces instead of tabs
vim.bo.softtabstop = 4 -- spaces when pressing tab
