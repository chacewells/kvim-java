-- Only applies to Java files
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.keymap.set('n', '<leader>r', ':!javac % && java %:r<CR>', { buffer = true })

-- Set indentation for Java files
vim.bo.expandtab = true -- use spaces instead of tabs
vim.bo.softtabstop = 2 -- spaces when pressing tab
