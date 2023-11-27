vim.g.mapleader = ' '      -- Space is the best leader key
vim.g.maplocalleader = ' ' -- Space is the best leader key

-- Put the shortcuts back to the config at the top in case it breaks further down
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
  'numToStr/Comment.nvim',   -- "gc" to comment visual regions/lines
  'f-person/git-blame.nvim', -- Git blame
  require 'jwinebrener.lazy.gitsigns',
  require 'jwinebrener.lazy.lazygit',
  'nvim-lualine/lualine.nvim', -- Status line
  require 'jwinebrener.lazy.nvim-cmp',
  require 'jwinebrener.lazy.nvim-dap',
  'nvim-treesitter/nvim-treesitter-context', -- Keep parent line visible
  require 'jwinebrener.lazy.onedark',
  require 'jwinebrener.lazy.telescope',
  require 'jwinebrener.lazy.telescope-file-browser',
  require 'jwinebrener.lazy.treesitter',
  'mbbill/undotree',
  'michaeljsmith/vim-indent-object', -- Treat indented sections as text objects
  'tpope/vim-sleuth',                -- Infer whitespace settings
  'tpope/vim-fugitive',              -- Infer whitespace settings
  'tpope/vim-surround',              -- Treat enclosing characters ([, {, ',) as text objects
  require 'jwinebrener.lazy.lsp_zero',
}
require('telescope').setup(require 'jwinebrener.plugin_setup.telescope')
require('telescope').load_extension 'file_browser'
pcall(require('telescope').load_extension, 'fzf') -- Enable telescope fzf native, if installed
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup(require 'jwinebrener.plugin_setup.treesitter')
end, 0)
require('onedark').setup(require 'jwinebrener.plugin_setup.onedark')
require('onedark').load()
require('lualine').setup(require 'jwinebrener.plugin_setup.lualine')
require('mason').setup {}
require 'keymaps'

local servers = { 'lua_ls', 'rust_analyzer', 'ruff_lsp', 'gopls' }
local lsp_zero = require('lsp-zero')
lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({ buffer = bufnr })
  lsp_zero.buffer_autoformat()
end)
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = servers,
  handlers = {
    lsp_zero.default_setup,
  },
})
lsp_zero.setup_servers(servers)

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  })
})
