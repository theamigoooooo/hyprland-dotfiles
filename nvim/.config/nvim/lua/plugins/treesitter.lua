return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',

    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'cpp',
          'c',
          'lua',
        },

        highlight = {
          enable = true,
        },
      }
    end,
  },
}

