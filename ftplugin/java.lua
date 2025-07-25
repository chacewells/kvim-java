-- Only applies to Java files  
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.keymap.set('n', '<leader>r', ':!javac % && java %:r<CR>', { buffer = true })

-- Start jdtls when opening Java files
local jdtls = require('jdtls')

-- ftplugin/java.lua: call start_or_attach when a Java file is loaded
jdtls.start_or_attach({
    cmd = {
        vim.fn.expand'$HOME/.local/share/nvim/mason/bin/jdtls',
        ('--jvm-arg=-javaagent:%s'):format(vim.fn.expand'$HOME/.local/share/nvim/mason/packages/jdtls/lombok.jar')
    }
})
-- ... jdtls config here
