return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
  config = function()
    vim.keymap.set('n', '<leader>sr', require('telescope.builtin').oldfiles, {
      desc = '[S]earch [R]ecently opened',
    })
    vim.keymap.set('n', '<leader>sb', require('telescope.builtin').buffers, {
      desc = '[S]earch open [B]uffers',
    })
    vim.keymap.set('n', '<leader>sc', function()
      require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[S]earch [C]urrently open buffer' })
    vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, {
      desc = '[S]earch [F]iles',
    })
    vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, {
      desc = '[S]earch [H]elp',
    })
    vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, {
      desc = '[S]earch current [W]ord',
    })
    vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, {
      desc = '[S]earch by [G]rep',
    })
    vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, {
      desc = '[S]earch [D]iagnostics',
    })
    vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, {
      desc = '[S]earch [R]esume',
    })
    vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, {
      desc = '[S]earch [K]eymaps'
    })
    vim.keymap.set('n', '<leader>sj', require('telescope.builtin').jumplist, {
      desc = '[S]earch [J]umplist'
    })

    require 'telescope'.setup {
      defaults = {
        mappings = {
          i = {
            ['<C-t>'] = require('telescope.actions').select_tab,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
    }
    pcall(require('telescope').load_extension, 'fzf')
  end
}
