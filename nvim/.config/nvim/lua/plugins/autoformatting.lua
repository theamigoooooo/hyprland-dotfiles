return {
  {
    'stevearc/conform.nvim',

    event = { 'BufWritePre' },

    cmd = { 'ConformInfo' },

    keys = {
      {
        '<leader>f',
        function()
          require('conform').format {
            async = true,
            lsp_fallback = true,
          }
        end,
        desc = '[F]ormat buffer',
      },
    },

    opts = {
      notify_on_error = false,

      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },

      formatters_by_ft = {
        lua = { 'stylua' },

        c = { 'clang_format' },
        cpp = { 'clang_format' },

        python = {
          'ruff_format',
          'ruff_organize_imports',
        },

        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },

        javascriptreact = {
          'prettierd',
          'prettier',
          stop_after_first = true,
        },

        typescriptreact = {
          'prettierd',
          'prettier',
          stop_after_first = true,
        },

        json = { 'prettierd', 'prettier', stop_after_first = true },
        html = { 'prettierd', 'prettier', stop_after_first = true },
        css = { 'prettierd', 'prettier', stop_after_first = true },
        markdown = { 'prettierd', 'prettier', stop_after_first = true },

        sh = { 'shfmt' },

        rust = { 'rustfmt' },
      },
    },
  },
}
