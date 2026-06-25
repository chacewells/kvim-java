-- Neovim 0.12.3 starts Treesitter from the bundled markdown ftplugin.
-- Stop it until the markdown injection highlighter crash is fixed upstream.
pcall(vim.treesitter.stop, 0)

-- Keep ordinary Vim syntax highlighting available for markdown buffers.
vim.bo.syntax = 'markdown'
