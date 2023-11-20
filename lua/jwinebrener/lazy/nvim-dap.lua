return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    -- Add your own debuggers here
    'mfussenegger/nvim-dap-python',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      automatic_setup = true, -- Allow vim best effort first
    }

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<leader>dc', dap.continue, { desc = '[D]ebug [C]ontinue' })
    vim.keymap.set('n', '<leader>di', dap.step_into, { desc = '[D]ebug step [I]nto' })
    vim.keymap.set('n', '<leader>dn', dap.step_over, { desc = '[D]ebug [N]ext' })
    vim.keymap.set('n', '<leader>do', dap.step_out, { desc = '[D]ebug step [O]ut' })
    vim.keymap.set('n', '<leader>de', dap.stop, { desc = '[D]ebug [E]xit' })
    vim.keymap.set('n', '<leader>dp', dap.pause, { desc = '[D]ebug [P]ause' })
    vim.keymap.set('n', '<leader>dr', dap.restart, { desc = '[D]ebug [R]estart' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Set debug [B]reakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Set conditional debug [B]reakpoint' })

    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
    }
    vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = '[D]ebugger [U]I toggle' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open

    local dap_py = require 'dap-python'
    local path = vim.loop.cwd() .. '/.venv/Scripts/python.exe'
    if not pcall(dap_py.setup, path) then
      if not pcall(dap_py.setup, 'python3') then
        dap_py.setup 'py'
      end
    end
    dap_py.test_runner = 'pytest'
    vim.keymap.set('n', '<leader>dt', dap_py.test_method, { desc = 'Debug: [D]ebug [T]est' })
    require('dap.ext.vscode').load_launchjs()
  end,
}
