return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'hrsh7th/nvim-cmp', -- Optional: For using slash commands and variables in the chat buffer
    'nvim-telescope/telescope.nvim', -- Optional: For using slash commands
    { 'stevearc/dressing.nvim', opts = {} }, -- Optional: Improves `vim.ui.select`
  },
  config = function()
    require('codecompanion').setup {
      strategies = {
        chat = {
          adapter = 'gemini',
          keymaps = {
            send = {
              modes = { n = '<C-s>', i = '<C-s>' },
            },
            close = {
              modes = { n = '<C-c>', i = '<C-c>' },
            },
          },
        },
        inline = {
          adapter = 'ollama',
        },
        agent = {
          adapter = 'ollama',
        },
      },
      adapters = {
        ollama = function()
          return require('codecompanion.adapters').extend('ollama', {
            env = {
              url = 'http://localhost:11434',
            },
            headers = {
              ['Content-Type'] = 'application/json',
            },
            parameters = {
              sync = true,
            },
          })
        end,
        gemini = function()
          return require('codecompanion.adapters').extend('gemini', {
            env = {
              api_key = 'AIzaSyDFg6mxlPrdgO4p4pAe7v1vpxJtDRbzGlY',
            },
          })
        end,
      },
      display = {
        chat = {
          show_settings = true,
          show_token_count = true,
          window = {
            layout = 'vertical',
            position = 'right',
            width = 0.35,
            opts = {
              breakindent = true,
              cursorcolumn = false,
              cursorline = false,
              foldcolumn = '0',
              linebreak = true,
              list = false,
              number = true,
              relativenumber = false,
              signcolumn = 'auto',
              spell = false,
              wrap = true,
            },
          },
        },
      },
    }
  end,
}
