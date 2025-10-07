vim.api.nvim_create_autocmd('FileType', {
  pattern = 'java',
  callback = function()
    require('custom.jdtls.jdtls_setup').setup()
  end,
})
