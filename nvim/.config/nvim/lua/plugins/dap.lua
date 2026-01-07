return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'nvim-neotest/nvim-nio', -- REQUIRED for dap-ui
  },

  config = function()
    -----------------------------------------
    -- Mason setup
    -----------------------------------------
    require('mason').setup()
    require('mason-nvim-dap').setup {
      ensure_installed = { 'cppdbg', 'codelldb' },
      automatic_setup = true,
    }

    -----------------------------------------
    -- DAP + UI setup
    -----------------------------------------
    local dap = require 'dap'
    local dapui = require 'dapui'

    dapui.setup()
    require('nvim-dap-virtual-text').setup()

    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end

    -----------------------------------------
    -- C/C++/Rust (LLDB)
    -----------------------------------------
    dap.adapters.lldb = {
      type = 'executable',
      command = '/usr/bin/lldb-vscode',
      name = 'lldb',
    }

    dap.configurations.cpp = {
      {
        name = 'Launch (LLDB)',
        type = 'lldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }

    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp

    -----------------------------------------
    -- Keymaps
    -----------------------------------------
    local map = vim.keymap.set
    map('n', '<F5>', dap.continue)
    map('n', '<F10>', dap.step_over)
    map('n', '<F11>', dap.step_into)
    map('n', '<F12>', dap.step_out)

    map('n', '<leader>b', dap.toggle_breakpoint)
    map('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint: ')
    end)

    map('n', '<leader>dr', dap.repl.open)
    map('n', '<leader>du', dapui.toggle)
  end,
}
