return {
  {
    'nvim-java/nvim-java',
    dependencies = {
      'nvim-java/lua-async-await',
      'nvim-java/nvim-java-core',
      'nvim-java/nvim-java-test',
      'nvim-java/nvim-java-dap',
      'nvim-java/nvim-java-refactor',
      'MunifTanjim/nui.nvim',
      'neovim/nvim-lspconfig',
      'mfussenegger/nvim-dap',
      {
        'williamboman/mason.nvim',
        opts = {
          registries = {
            'github:nvim-java/mason-registry',
            'github:mason-org/mason-registry',
          },
        },
      },
    },
    ft = { 'java' },
    config = function()
      -- Setup nvim-java before lspconfig
      require('java').setup {
        -- Specify the JDK installation you're using
        jdk = {
          auto_install = false, -- We'll use your existing JDK
        },
        notifications = {
          dap = true, -- Enable DAP notifications
        },
        verification = {
          invalid_order = true,
          duplicate_setup_calls = true,
        },
      }

      -- Configure JDTLS through nvim-java
      require('lspconfig').jdtls.setup {
        -- nvim-java will handle most of the configuration
        -- Add any custom settings here if needed
        settings = {
          java = {
            configuration = {
              root_markers = {
                'settings.gradle',
                'gradlew',
                '.git',
              },
              runtimes = {
                {
                  name = 'JavaSE-17',
                  path = vim.fn.expand '~/.sdkman/candidates/java/17.0.16-amzn',
                },
              },
            },
            compile = {
              nullAnalysis = {
                mode = 'automatic',
              },
            },
            completion = {
              favoriteStaticMembers = {
                'org.hamcrest.MatcherAssert.assertThat',
                'org.hamcrest.Matchers.*',
                'org.hamcrest.CoreMatchers.*',
                'org.junit.jupiter.api.Assertions.*',
                'java.util.Objects.requireNonNull',
                'java.util.Objects.requireNonNullElse',
                'org.mockito.Mockito.*',
              },
              importOrder = {
                'java',
                'javax',
                'com',
                'org',
              },
            },
            sources = {
              organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
              },
            },
            codeGeneration = {
              toString = {
                template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
              },
              hashCodeEquals = {
                useJava7Objects = true,
              },
              useBlocks = true,
            },
          },
        },
        on_attach = function(client, bufnr)
          -- Java-specific keymaps
          local opts = { noremap = true, silent = true, buffer = bufnr }

          vim.keymap.set(
            'n',
            '<leader>jo',
            '<Cmd>lua require("jdtls").organize_imports()<CR>',
            vim.tbl_extend('force', opts, { desc = '[J]ava [O]rganize Imports' })
          )
          vim.keymap.set(
            'n',
            '<leader>jv',
            '<Cmd>lua require("jdtls").extract_variable()<CR>',
            vim.tbl_extend('force', opts, { desc = '[J]ava Extract [V]ariable' })
          )
          vim.keymap.set(
            'v',
            '<leader>jv',
            '<Esc><Cmd>lua require("jdtls").extract_variable(true)<CR>',
            vim.tbl_extend('force', opts, { desc = '[J]ava Extract [V]ariable' })
          )
          vim.keymap.set(
            'n',
            '<leader>jc',
            '<Cmd>lua require("jdtls").extract_constant()<CR>',
            vim.tbl_extend('force', opts, { desc = '[J]ava Extract [C]onstant' })
          )
          vim.keymap.set(
            'v',
            '<leader>jc',
            '<Esc><Cmd>lua require("jdtls").extract_constant(true)<CR>',
            vim.tbl_extend('force', opts, { desc = '[J]ava Extract [C]onstant' })
          )
          vim.keymap.set(
            'v',
            '<leader>jm',
            '<Esc><Cmd>lua require("jdtls").extract_method(true)<CR>',
            vim.tbl_extend('force', opts, { desc = '[J]ava Extract [M]ethod' })
          )

          -- Test related keymaps
          vim.keymap.set(
            'n',
            '<leader>jtc',
            '<Cmd>lua require("java").test.run_current_class()<CR>',
            vim.tbl_extend('force', opts, { desc = '[J]ava [T]est [C]lass' })
          )
          vim.keymap.set(
            'n',
            '<leader>jtm',
            '<Cmd>lua require("java").test.run_current_method()<CR>',
            vim.tbl_extend('force', opts, { desc = '[J]ava [T]est [M]ethod' })
          )
          vim.keymap.set(
            'n',
            '<leader>jts',
            '<Cmd>lua require("java").test.goto_subjects()<CR>',
            vim.tbl_extend('force', opts, { desc = '[J]ava [T]est [S]ubjects' })
          )

          -- DAP keymaps for Java debugging
          vim.keymap.set(
            'n',
            '<leader>jdc',
            '<Cmd>lua require("java").dap.test_class()<CR>',
            vim.tbl_extend('force', opts, { desc = '[J]ava [D]ebug [C]lass' })
          )
          vim.keymap.set(
            'n',
            '<leader>jdm',
            '<Cmd>lua require("java").dap.test_nearest_method()<CR>',
            vim.tbl_extend('force', opts, { desc = '[J]ava [D]ebug [M]ethod' })
          )
        end,
      }
    end,
  },
}
