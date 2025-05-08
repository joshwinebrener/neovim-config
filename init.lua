------------------------------------------------
-- BASICS                                     --
-- (in case anything breaks farther down :) ) --
------------------------------------------------

vim.g.mapleader = ' '      -- Space is the best leader key
vim.g.maplocalleader = ' ' -- Space is the best leader key

-- Put the shortcuts back to the config at the top in case it breaks further down
vim.keymap.set(
  'n',
  '<leader>i',
  "<cmd>exe 'tabe '.stdpath('config').'/init.lua'<CR>",
  { desc = 'Edit [I]nit.lua' }
)
vim.keymap.set(
  'n',
  '<leader>I',
  "<cmd>exe 'tabe '.stdpath('config')<CR>",
  { desc = 'Explore [I]nit directory' }
)

-------------------------
-- LAZY PLUGIN MANAGER --
-------------------------

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
require('lazy').setup("plugins")

---------------------
-- EDITOR SETTINGS --
---------------------

vim.o.hlsearch = false                 -- Highlighting all searches is not the move
vim.wo.number = true                   -- Highlighting the next match while typing *is* the move
vim.wo.relativenumber = true           -- Relative numbering for speedyboi jumping
vim.o.mouse = 'a'                      -- Allow mouse usage in all modes
vim.o.breakindent = true               -- Indent wrapped lines
vim.o.undofile = true                  -- Persist undo history
vim.o.ignorecase = true                -- Case-insensitive searching...
vim.o.smartcase = true                 -- ... unless a capital is inserted
vim.wo.signcolumn = 'yes'              -- Reserve area left of line numbers for indicators
vim.o.updatetime = 250                 -- Write swap file to disk 4x per sec
vim.o.completeopt = 'menuone,noselect' -- Show completions in menu
vim.o.termguicolors = true             -- Show da fancy colors
vim.o.colorcolumn = '-1'               -- Line length indicator just before line will be split
vim.o.scrolloff = 15                   -- Keep enough lines above and below the cursor at all times
vim.o.exrc = true                      -- Use additional configuration from `.nvim.lua` in pwd

-- Momentarily highlight yanked content
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-------------
-- KEYMAPS --
-------------

-- Leader-d to diff visual selection to clipboard
local function compare_to_clipboard()
  local ftype = vim.api.nvim_eval("&filetype")
  vim.cmd(string.format([[
    execute "normal! \"xy"
    vsplit
    enew
    normal! P
    setlocal buftype=nowrite
    set filetype=%s
    diffthis
    execute "normal! \<C-w>\<C-w>"
    enew
    set filetype=%s
    normal! "xP
    diffthis
  ]], ftype, ftype))
end
vim.keymap.set('x', '<Space>d', compare_to_clipboard)

-- Don't do anything else with the leader key
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Don't skip wrapped lines when scrolling
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Ctrl-d and Ctrl-u automaticaly re-center
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>D', vim.diagnostic.open_float, {
  desc = 'Open floating diagnostic message',
})
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Explorer at cwd
vim.keymap.set('n', '<leader>e', "<cmd>execute 'e %/..'<cr>", { desc = 'Open explorer at cwd' })

-- Quick tab navigation
vim.keymap.set('n', '<leader>1', '1gt')
vim.keymap.set('n', '<leader>2', '2gt')
vim.keymap.set('n', '<leader>3', '3gt')
vim.keymap.set('n', '<leader>4', '4gt')
vim.keymap.set('n', '<leader>5', '5gt')

-- Easier save and quit
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>')
vim.keymap.set('n', '<leader>q', '<cmd>q<cr>')

-- Language server features
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'gr', vim.lsp.buf.references)
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)

----------------------
-- LANGUAGE SERVERS --
----------------------

local python_project_root = {
  'pyproject.toml',
  'setup.py',
  'setup.cfg',
  'requirements.txt',
  'pyrightconfig.json',
  '.git',
}
local language_servers = {

  luals = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.luarc.jsonc' },
  },

  ruff = {
    cmd = { 'ruff', 'server' },
    filetypes = { 'python' },
    root_markers = python_project_root,
    single_file_support = true,
    init_options = {
      settings = {
        lineLength = 100,
        configuration = {
          lint = {
            select = {
              "E4",
              "E7",
              "E9",
              "F",
              "I",
            },
          },
        }
      }
    }
  },

  basedpyright = {
    cmd = { 'basedpyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_markers = python_project_root,
    settings = {
      basedpyright = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = 'openFilesOnly',
        },
      },
    },
  }

}

for server, config in pairs(language_servers) do
  vim.lsp.config(server, config)
  vim.lsp.enable(server)
end

-- Enable format on save
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
        end,
      })
    end
  end,
})
