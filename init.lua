vim.g.mapleader = ' ' -- Space is the best leader key
vim.g.maplocalleader = ' ' -- Space is the best leader key
vim.keymap.set(
  'n',
  '<leader>i',
  "<cmd>exe 'tabedit '.stdpath('config').'/init.lua'<CR>",
  { desc = 'Edit [I]nit.lua' }
)
vim.keymap.set(
  'n',
  '<leader>I',
  "<cmd>exe 'tabedit '.stdpath('config')<CR>",
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
require('lazy').setup {
  'numToStr/Comment.nvim', -- "gc" to comment visual regions/lines
  'stevearc/conform.nvim',
  'numToStr/FTerm.nvim',
  'f-person/git-blame.nvim', -- Git blame
  require 'jwinebrener.lazy.gitsigns',
  require 'jwinebrener.lazy.lazygit',
  'nvim-lualine/lualine.nvim', -- Status line
  require 'jwinebrener.lazy.noice',
  'rcarriga/nvim-notify',
  require 'jwinebrener.lazy.nvim-cmp',
  require 'jwinebrener.lazy.nvim-dap',
  require 'jwinebrener.lazy.nvim-lspconfig',
  'nvim-treesitter/nvim-treesitter-context', -- Keep parent line visible
  'simrat39/symbols-outline.nvim',
  require 'jwinebrener.lazy.onedark',
  require 'jwinebrener.lazy.telescope',
  require 'jwinebrener.lazy.telescope-file-browser',
  require 'jwinebrener.lazy.treesitter',
  'mbbill/undotree',
  'michaeljsmith/vim-indent-object', -- Treat indented sections as text objects
  'tpope/vim-sleuth', -- Infer whitespace settings
  'tpope/vim-surround', -- Treat enclosing characters ([, {, ',) as text objects
  'folke/which-key.nvim',
}
require 'keymaps'
require 'jwinebrener.plugin_setup.treesitter'
require 'jwinebrener.plugin_setup.telescope'
require 'jwinebrener.plugin_setup.fterm'
require('mason').setup {}
require('mason-lspconfig').setup {}
require 'lsp' -- Depends on mason
require('Comment').setup()
require 'jwinebrener.plugin_setup.noice'
require 'jwinebrener.plugin_setup.notify'
require 'jwinebrener.plugin_setup.lazygit'
require('onedark').setup(require 'jwinebrener.plugin_setup.onedark')
require('onedark').load()
require 'jwinebrener.plugin_setup.lualine'
