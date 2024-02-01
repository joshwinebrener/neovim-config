return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'mfussenegger/nvim-dap-python',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      automatic_setup = true,
    }

    vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<leader>dp', dap.pause, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<leader>do', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<leader>dO', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>dB', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Set conditional debug [B]reakpoint' })

    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
    }
    vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = 'Debug: Toggle UI' })
    require("dap").set_exception_breakpoints({ "Warning", "Error", "Exception" })

    local dap_py = require 'dap-python'
    local path = vim.loop.cwd() .. '/.venv/Scripts/python.exe'
    if not pcall(dap_py.setup, path) then
      if not pcall(dap_py.setup, 'python3') then
        dap_py.setup 'py'
      end
    end
    dap_py.test_runner = 'pytest'
    vim.keymap.set('n', '<leader>dpt', dap_py.test_method, { desc = 'Debug: [D]ebug [P]ython [T]est' })
    require('dap.ext.vscode').load_launchjs()
  end,
}
