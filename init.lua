vim.g.mapleader = ' '      -- Space is the best leader key
vim.g.maplocalleader = ' ' -- Space is the best leader key

-- Put the shortcuts back to the config at the top in case it breaks further down
vim.keymap.set(
  'n',
  '<leader>i',
  "<cmd>exe 'e '.stdpath('config').'/init.lua'<CR>",
  { desc = 'Edit [I]nit.lua' }
)
vim.keymap.set(
  'n',
  '<leader>I',
  "<cmd>exe 'e '.stdpath('config')<CR>",
  { desc = 'Explore [I]nit directory' }
)

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',

    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require 'settings'
require('lazy').setup("plugins")
require 'keymaps'
