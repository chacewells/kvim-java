-- Plugin manager: install vim-test
return {
  'vim-test/vim-test',

  config = function()
    -- optional: run tests in a floating terminal/buffer instead of blocking Vim:
    vim.g['test#strategy'] = 'neovim'

    -- pick the GradleTest runner (not the default “test” command)
    vim.g['test#java#runner'] = 'gradletest'

    -- point it at your wrapper (omit the “test” subcommand here!)
    vim.g['test#java#gradletest#executable'] = 'JAVA_HOME=' .. vim.fn.expand '~/.sdkman/candidates/java/17.0.16-amzn' .. ' ./gradlew test'

    local opts = { silent = true, noremap = true }

    -- vim-test mappings
    vim.keymap.set('n', '<leader>tn', '<cmd>TestNearest<CR>', opts)
    vim.keymap.set('n', '<leader>tf', '<cmd>TestFile<CR>', opts)
    vim.keymap.set('n', '<leader>ta', '<cmd>TestSuite<CR>', opts)
    vim.keymap.set('n', '<leader>tl', '<cmd>TestLast<CR>', opts)
    vim.keymap.set('n', '<leader>tg', '<cmd>TestVisit<CR>', opts)
  end,
}
