return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim', branch = 'master' },
      { 'github/copilot.vim' },
    },
    lazy = false,
    keys = {
      { '<leader>cc', '<cmd>CopilotChatToggle<cr>', desc = '[C]opilot [C]hat Toggle' },
      { '<leader>cq', '<cmd>CopilotChatClose<cr>', desc = '[C]opilot Chat [Q]uit' },
      { '<leader>cr', '<cmd>CopilotChatReset<cr>', desc = '[C]opilot Chat [R]eset' },
    },
    build = 'make tiktoken',
    config = function()
      require('CopilotChat').setup({
        debug = true, -- Enable debugging for troubleshooting
      })
    end,
  },
}
