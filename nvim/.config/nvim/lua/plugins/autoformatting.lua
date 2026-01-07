-- Format on save and linters
return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
    'jayp0521/mason-null-ls.nvim', -- ensure dependencies are installed
  },
  config = function()
    local null_ls = require 'null-ls'
    local formatting = null_ls.builtins.formatting   -- to setup formatters
    local diagnostics = null_ls.builtins.diagnostics -- to setup linters

    -- list of formatters & linters for mason to install
    require('mason-null-ls').setup {
      ensure_installed = {
        'checkmake',
        'prettier',  -- ts/js/jsx/tsx/html/css/json formatter
        'eslint_d',  -- ts/js/jsx/tsx linter
        'shfmt',
        'rustfmt',
        -- 'stylua', -- lua formatter; Already installed via Mason
        -- 'ruff',   -- Python linter and formatter; Already installed via Mason
      },
      automatic_installation = true,
    }

    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
    local function enable_format_on_save(client, bufnr)
      if client and client.supports_method 'textDocument/formatting' then
        vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format { bufnr = bufnr, async = false }
          end,
        })
      end
    end

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('LspAttachFormat', { clear = true }),
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        enable_format_on_save(client, event.buf)
      end,
    })

    local sources = {
      diagnostics.checkmake,
      formatting.prettier.with {
        filetypes = {
          'html', 'json', 'yaml', 'markdown',
          'javascript', 'javascriptreact', -- JSX
          'typescript', 'typescriptreact', -- TSX
          'css', 'scss'
        },
      },
      formatting.stylua,
      formatting.shfmt.with { args = { '-i', '4' } },
      formatting.terraform_fmt,
      formatting.clang_format,
      formatting.rustfmt,
      require('none-ls.formatting.ruff').with { extra_args = { '--extend-select', 'I' } },
      require 'none-ls.formatting.ruff_format',
    }

    null_ls.setup {
      sources = sources,
      on_attach = enable_format_on_save,
    }
  end,
}
