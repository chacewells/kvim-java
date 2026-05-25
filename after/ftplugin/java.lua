-- Only applies to Java files
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = true -- use spaces instead of tabs
vim.opt_local.formatoptions:remove 't'
vim.opt_local.formatoptions:remove 'c'

-- Simple run keymap for standalone Java files (nvim-java handles project files)
-- vim.keymap.set('n', '<leader>r', ':!javac % && java %:r<CR>', { buffer = true, desc = '[R]un Java file' })

-- Additional Java-specific settings
vim.opt_local.colorcolumn = '120' -- Java convention line length
vim.opt_local.textwidth = 120

-- Custom command to run the current Java file with Gradle
local function get_fully_qualified_classname()
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local package = ''

  -- Find package declaration
  for _, line in ipairs(lines) do
    local pkg = line:match '^%s*package%s+([%w%.]+)%s*;'
    if pkg then
      package = pkg
      break
    end
  end

  -- Get class name from filename (without .java extension)
  local filename = vim.fn.expand '%:t:r'

  -- Construct fully qualified name
  if package ~= '' then
    return package .. '.' .. filename
  else
    return filename
  end
end

vim.api.nvim_buf_create_user_command(0, 'JavaRunCurrent', function()
  local fqcn = get_fully_qualified_classname()
  vim.cmd('!./gradlew run -PmainClass=' .. fqcn)
end, { desc = 'Run current Java class with Gradle' })

vim.keymap.set('n', '<leader>r', ':JavaRunCurrent<CR>', { buffer = true, desc = '[R]un current Java class' })
