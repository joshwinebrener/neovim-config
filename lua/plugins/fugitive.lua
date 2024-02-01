return {
  'tpope/vim-fugitive',
  config = function()
    vim.keymap.set('n', 'ul', '<cmd>diffget \\2<cr>', { desc = '[U]se [L]eft' })
    vim.keymap.set('n', 'ur', '<cmd>diffget \\3<cr>', { desc = '[U]se [R]eft' })
  end
}
