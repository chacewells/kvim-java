return {
  'CopilotC-Nvim/CopilotChat.nvim',
  dependencies = {
    { 'nvim-lua/plenary.nvim', branch = 'master' },
  },
  build = 'make tiktoken',
  opts = {
    window = { layout = 'float' },
    model = 'claude-sonnet-4',
  },
  keys = {
    { '<leader>cc', '<cmd>CopilotChatToggle<cr>', desc = 'Toggle CopilotChat panel' },
    { '<leader>cx', '<cmd>CopilotChatExplain<cr>', desc = 'CopilotChat explain' },
    { '<leader>cf', '<cmd>CopilotChatFix<cr>', desc = 'CopilotChat fix' },
  },
}
