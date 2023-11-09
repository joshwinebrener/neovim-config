require('lazy').setup {
  'tpope/vim-fugitive', -- Git
  -- 'tpope/vim-rhubarb', -- Fugitive for GitHub
  'tpope/vim-surround', -- Treat enclosing characters ([, {, ',) as text objects
  'tpope/vim-sleuth', -- Infer whitespace settings
  'michaeljsmith/vim-indent-object', -- Treat indented sections as text objects
  'nvim-treesitter/nvim-treesitter-context', -- Keep parent line visible
  'f-person/git-blame.nvim', -- Git blame
  'folke/which-key.nvim',
  'simrat39/symbols-outline.nvim',
  'stevearc/conform.nvim',
  'mbbill/undotree',
  'rcarriga/nvim-notify',
  {
    'neovim/nvim-lspconfig', -- LSP, duh
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
      'folke/neodev.nvim',
    },
  },
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'rafamadriz/friendly-snippets',
    },
  },
  {
    -- In-editor git hunk support
    'lewis6991/gitsigns.nvim',
    opts = {
      -- 		-- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, {
          buffer = bufnr,
          desc = 'Preview git hunk',
        })

        -- don't override the built-in and fugitive keymaps
        local gs = package.loaded.gitsigns
        vim.keymap.set({ 'n', 'v' }, ']h', function()
          if vim.wo.diff then
            return ']h'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
        vim.keymap.set({ 'n', 'v' }, '[h', function()
          if vim.wo.diff then
            return '[h'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
      end,
    },
  },
  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },
  { 'nvim-lualine/lualine.nvim', opts = {} }, -- Status line
  -- Add indentation guides even on blank lines
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
  },
  { 'numToStr/Comment.nvim', opts = {} }, -- "gc" to comment visual regions/lines
  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make', -- NOTE: requires `make` installed on PC
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },
  -- Highlight, edit, and navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
  {
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
  },
  {
    -- File tree
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
    },
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
  },
}

require('noice').setup {
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
      ['cmp.entry.get_documentation'] = true,
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
}

local notify = require 'notify'
notify.setup {
  background_colour = '#000000',
}
vim.notify = notify

require '_telescope'
require 'treesitter'
require('lualine').setup()
require 'outline'
