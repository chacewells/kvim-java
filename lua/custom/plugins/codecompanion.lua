-- lua/plugins/codecompanion.lua
return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    local cc = require 'codecompanion'

    cc.setup {
      adapters = {
        -- Use the Copilot adapter
        copilot = function()
          -- Minimal: use defaults and pick a model below
          return require('codecompanion.adapters').extend('copilot', {
            -- Set a default model you have access to via Copilot/GitHub Models
            -- (Examples that commonly work: "gpt-4o-mini", "gpt-4o", "o3-mini")
            schema = { model = { default = 'gpt-4o-mini' } },
          })
        end,
      },

      -- Point the features at Copilot
      strategies = {
        chat = { adapter = 'copilot' },
        inline = { adapter = 'copilot' },
        agent = { adapter = 'copilot' },
      },

      -- Good defaults for a “diff-first” flow
      system_prompt = 'Be concise. Propose unified diffs for multi-file edits.',
      opts = {
        send_code = true, -- include current buffer when asking for changes
      },

      -- Optional: simple “tools” the agent can call (ripgrep, tests, etc.)
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
