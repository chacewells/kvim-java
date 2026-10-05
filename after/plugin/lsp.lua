vim.api.nvim_create_autocmd('FileType', {
  pattern = 'java',
  callback = function(args)
    -- Skip jdtls for any project containing a `.nojdtls` marker file
    local bufdir = vim.fs.dirname(vim.api.nvim_buf_get_name(args.buf))
    if vim.fs.find('.nojdtls', { upward = true, path = bufdir })[1] then
      return
    end
    require('custom.jdtls.jdtls_setup').setup()
  end,
})
