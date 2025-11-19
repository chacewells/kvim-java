local M = {}

function M:setup()
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
  local workspace_dir = vim.fn.stdpath 'data' .. '/workspaces/' .. project_name -- todo get workspace data directory
  local java = vim.fn.expand '~/.sdkman/candidates/java/21.0.7-tem/bin/java'
  local lombok = vim.fn.stdpath 'data' .. '/mason/packages/jdtls/lombok.jar'
  local config = {
    cmd = {
      java, -- path to java 21
      '-Declipse.application=org.eclipse.jdt.ls.core.id1',
      '-Dosgi.bundles.defaultStartLevel=4',
      '-Declipse.product=org.eclipse.jdt.ls.core.product',
      '-Dlog.protocol=true',
      '-Dlog.level=ALL',
      '-Xmx1g',
      '--add-modules=ALL-SYSTEM',
      '--add-opens',
      'java.base/java.util=ALL-UNNAMED',
      '--add-opens',
      'java.base/java.lang=ALL-UNNAMED',
      -- java agents must be configured before -jar parameters
      '-javaagent:' .. lombok,
      -- point to eclipse.jdt.ls launcher jar
      '-jar',
      '/Users/awells10/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.7.0.v20250519-0528.jar',
      '-configuration',
      -- eclipse.jdt.ls configuration dir (likely mac_arm or something)
      '/Users/awells10/.local/share/nvim/mason/packages/jdtls/config_mac_arm',
      '-data',
      workspace_dir,
    },
    root_dir = require('jdtls.setup').find_root { '.git', 'mvnw', 'gradlew' },
    -- eclipse.jdt.ls specific settings
    -- available options: https://github.com/eclipse-jdtls/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line
    settings = {
      java = {
        configuration = {
          runtimes = {
            {
              name = 'JavaSE-21',
              path = '/Users/awells10/.sdkman/candidates/java/21.0.7-tem',
            },
            {
              name = 'JavaSE-17',
              path = '/Users/awells10/.sdkman/candidates/java/17.0.12-tem',
            },
            {
              name = 'JavaSE-11',
              path = '/Users/awells10/.sdkman/candidates/java/11.0.29-tem',
            },
          },
          project = {
            referencedLibraries = {
              'build/*/java/main',
            },
          },
        },
      },
    },
    -- language server initialization options
    -- expend `bundles` with paths to jar files
    -- if you wan to use additional eclipse.jdt.ls plugins
    --
    -- see https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    init_options = {
      bundles = {},
    },
  }
  require('jdtls').start_or_attach(config)
end

return M
