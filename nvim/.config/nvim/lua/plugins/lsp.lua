return {
  'neovim/nvim-lspconfig',

  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
  },

  config = function()
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    vim.lsp.config('clangd', {
      capabilities = capabilities,

      cmd = {
        'clangd',
        '--background-index',
        '--clang-tidy',
        '--completion-style=detailed',
      },
    })

    vim.lsp.enable 'clangd'
  end,
}
