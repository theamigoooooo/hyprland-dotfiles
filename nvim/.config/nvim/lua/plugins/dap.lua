return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'nvim-neotest/nvim-nio', -- REQUIRED for dap-ui
    'Weissle/persistent-breakpoints.nvim',
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
    -- Persistent Breakpoints Setup
    -----------------------------------------
    require('persistent-breakpoints').setup {
      load_breakpoints_event = { 'BufReadPost' },
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
    -- Keep UI open after execution ends to let the user inspect results/status
    -- dap.listeners.before.event_terminated['dapui_config'] = function()
    --   dapui.close()
    -- end
    -- dap.listeners.before.event_exited['dapui_config'] = function()
    --   dapui.close()
    -- end

    -----------------------------------------
    -- C/C++/Rust (CodeLLDB via Mason)
    -----------------------------------------
    local codelldb_path = vim.fn.stdpath 'data' .. '/mason/bin/codelldb'
    dap.adapters.codelldb = {
      type = 'server',
      port = '${port}',
      executable = {
        command = codelldb_path,
        args = { '--port', '${port}' },
      },
    }
    dap.adapters.lldb = dap.adapters.codelldb

    dap.configurations.cpp = {
      {
        name = 'Launch (CodeLLDB)',
        type = 'codelldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
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

    -- Persistent breakpoints mapping
    local p_bp = require 'persistent-breakpoints.api'
    map('n', '<leader>b', p_bp.toggle_breakpoint)
    map('n', '<leader>B', p_bp.set_conditional_breakpoint)

    map('n', '<leader>dr', dap.repl.open)
    map('n', '<leader>du', dapui.toggle)
    map('n', '<leader>dq', function()
      dap.terminate()
      dapui.close()
    end, { desc = 'Terminate Debugger' })

    -- Toggle breakpoint with left click in the sign/gutter column
    map('n', '<LeftMouse>', function()
      local pos = vim.fn.getmousepos()
      if pos.winid > 0 and pos.wincol <= vim.fn.getwininfo(pos.winid)[1].textoff then
        vim.api.nvim_set_current_win(pos.winid)
        vim.api.nvim_win_set_cursor(pos.winid, { pos.line, 0 })
        p_bp.toggle_breakpoint()
      else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<LeftMouse>', true, false, true), 'n', false)
      end
    end, { desc = 'Left click in sign column to toggle breakpoint' })
  end,
}
