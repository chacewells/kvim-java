-- Python debugging configuration using nvim-dap
return {
  'mfussenegger/nvim-dap-python',
  ft = 'python',
  dependencies = {
    'mfussenegger/nvim-dap',
  },
  config = function()
    -- You'll need to install debugpy: pip install debugpy
    -- This assumes you have python3 available and debugpy installed
    local dap_python = require('dap-python')
    
    -- Try to find python with debugpy, fallback to python3
    local python_path = vim.fn.exepath('python3') or vim.fn.exepath('python')
    if python_path ~= '' then
      dap_python.setup(python_path)
    end
    
    -- Optional: Configure test runner for debugging
    dap_python.test_runner = 'pytest'
    
    -- Key mappings for Python debugging
    vim.keymap.set('n', '<leader>dn', function()
      require('dap-python').test_method()
    end, { desc = '[D]ebug [N]earest test method' })
    
    vim.keymap.set('n', '<leader>dc', function()
      require('dap-python').test_class()
    end, { desc = '[D]ebug test [C]lass' })
    
    vim.keymap.set('v', '<leader>ds', function()
      require('dap-python').debug_selection()
    end, { desc = '[D]ebug [S]election' })
  end,
}
