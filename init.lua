vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require 'plugins'
require('lualine').setup()
require 'settings'
require 'theme'
require '_telescope'
require 'treesitter'
require 'keymaps'
require 'outline'
require('mason').setup()
require('mason-lspconfig').setup()
-- LSP features require mason to install some stuff, so keep this last
require 'lsp'
