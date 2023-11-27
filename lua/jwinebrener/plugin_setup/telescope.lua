vim.keymap.set('n', '<leader>sr', require('telescope.builtin').oldfiles, {
  desc = '[S]earch [R]ecently opened',
})
vim.keymap.set('n', '<leader>sb', require('telescope.builtin').buffers, {
  desc = '[S]earch open [B]uffers',
})
vim.keymap.set('n', '<leader>sc', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[S]earch [C]urrently open buffer' })
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, {
  desc = 'Search [G]it [F]iles',
})
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
vim.keymap.set(
  'n',
  '<leader>f',
  require('telescope').extensions.file_browser.file_browser,
  { desc = '[F]ile browser' }
)

require('telescope').setup {
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
  extensions = {
    file_browser = {
      hijack_netrw = true, -- Use instead of NetRW
      hidden = { file_browser = true, folder_browser = true },
      mappings = {
        ['i'] = {
          ['<F2>'] = require('telescope._extensions.file_browser.actions').rename,
          ['<C-x>'] = require('telescope._extensions.file_browser.actions').move,
          ['<C-y>'] = require('telescope._extensions.file_browser.actions').copy,
          ['<C-d>'] = require('telescope._extensions.file_browser.actions').remove,
          ['<C-o>'] = require('telescope._extensions.file_browser.actions').open,
        },
        ['n'] = {
          ['n'] = require('telescope._extensions.file_browser.actions').create,
          ['<F2>'] = require('telescope._extensions.file_browser.actions').rename,
          ['x'] = require('telescope._extensions.file_browser.actions').move,
        },
      },
    },
  },
}
require('telescope').load_extension 'file_browser'
pcall(require('telescope').load_extension, 'fzf') -- Enable telescope fzf native, if installed
