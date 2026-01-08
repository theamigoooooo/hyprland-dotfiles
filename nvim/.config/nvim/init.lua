require 'core.options'
require 'core.keymaps'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  require 'plugins.theme',
  require 'plugins.bufferline',
  require 'plugins.neotree',
  require 'plugins.lualine',
  require 'plugins.treesitter',
  require 'plugins.telescope',
  require 'plugins.lsp',
  require 'plugins.autocompletion',
  require 'plugins.autoformatting',
  require 'plugins.linting',
  require 'plugins.wal',
  require 'plugins.oil',
  require 'plugins.autopairs',
  require 'plugins.dap',
  require 'plugins.ai',
}

vim.cmd [[
  highlight Normal ctermbg=none guibg=none
  highlight NonText ctermbg=none guibg=none
]]
