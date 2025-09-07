-- filepath: /Users/awells10/.config/kickstart.nvim/lua/custom/plugins/codecompanion.lua
return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    local ok, cc = pcall(require, 'codecompanion')
    if not ok then
      vim.notify('Failed to load CodeCompanion: ' .. cc, vim.log.levels.ERROR)
      return
    end

    cc.setup {
      adapters = {
        http = {
          -- Use the Copilot adapter
          copilot = function()
            return require('codecompanion.adapters').extend('copilot', {
              schema = { model = { default = 'gpt-4o-mini' } },
            })
          end,
        },
      },

      strategies = {
        chat = { adapter = 'copilot' },
        inline = { adapter = 'copilot' },
        agent = { adapter = 'copilot' },
      },

      system_prompt = 'Be concise. Propose unified diffs for multi-file edits.',
      opts = {
        send_code = true, -- include current buffer when asking for changes
      },
      tools = {
        grep = {
          command = 'rg',
          args = { '--line-number', '--hidden', '--glob', '!.git', '$INPUT' },
          description = 'Search repo with ripgrep',
        },
        tests = {
          command = 'make',
          args = { 'test' },
          description = 'Run test suite',
        },
      },
    }

    -- Keymaps (tweak to taste)
    vim.keymap.set('n', '<leader>ac', function()
      cc.toggle()
    end, { desc = 'CodeCompanion Chat' })
    vim.keymap.set('v', '<leader>ai', function()
      cc.prompt 'inline'
    end, { desc = 'Inline edit (visual)' })
    vim.keymap.set('n', '<leader>ad', function()
      cc.actions.diff()
    end, { desc = 'Show last proposed diff' })
    vim.keymap.set('n', '<leader>aa', function()
      cc.actions.apply_diff()
    end, { desc = 'Apply proposed diff' })
  end,
}
