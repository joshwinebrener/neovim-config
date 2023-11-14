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
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<leader>dp', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<S-F5>', dap.pause, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F9>', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<F10>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F11>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        -- icons = {
        --   pause = '⏸',
        --   play = '▶',
        --   step_into = '⏎',
        --   step_over = '⏭',
        --   step_out = '⏮',
        --   step_back = 'b',
        --   run_last = '▶▶',
        --   terminate = '⏹',
        --   disconnect = '⏏',
        -- },
      },
    }
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

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
