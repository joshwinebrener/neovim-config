vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- //// ///////
-- LAZY PLUGINS
-- //// ///////

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

require('lazy').setup({
  'tpope/vim-fugitive', -- Git
  'tpope/vim-rhubarb', -- Fugitive for GitHub
  'tpope/vim-sleuth', -- Automatically sets whitespace options per file
  'tpope/vim-surround', -- Treat enclosing characters ([, {, ',) as text objects
  'michaeljsmith/vim-indent-object', -- Treat indented sections as text objects
  {
    'neovim/nvim-lspconfig', -- LSP, duh
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
      'folke/neodev.nvim',
    },
  },
  'f-person/git-blame.nvim', -- Git blame
  {
    'hrsh7th/nvim-cmp', -- Autocompletion
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'rafamadriz/friendly-snippets',
    },
  },
  { 'folke/which-key.nvim',      opts = {} }, -- Shows available bindings from previous keypress
  {
    -- In-editor git hunk support
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
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
          desc = 'Preview git hunk'
        })

        -- don't override the built-in and fugitive keymaps
        local gs = package.loaded.gitsigns
        vim.keymap.set({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
        vim.keymap.set({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
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

  require 'kickstart.plugins.autoformat', -- LSP autoformatting on save
  require 'kickstart.plugins.debug', -- Debugger

  -- File tree
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    }
  }
}, {})

-- /// ///////
-- VIM OPTIONS
-- /// ///////

vim.o.hlsearch = true -- Highlight all search matches
vim.wo.number = true -- It's honestly kinda stupid that vim doesn't enable line numbering default
vim.wo.relativenumber = true -- Relative numbering for speedyboi jumping
vim.o.mouse = 'a' -- Allow mouse usage in all modes
vim.o.breakindent = true -- Indent wrapped lines
vim.o.undofile = true -- Persist undo history
vim.o.ignorecase = true -- Case-insensitive searching...
vim.o.smartcase = true -- ... unless a capital is inserted
vim.wo.signcolumn = 'yes' -- Reserve area left of line numbers for indicators
vim.o.updatetime = 250 -- Write swap file to disk 4x per sec
vim.o.timeoutlen = 300 -- You have this long to finish a command sequence
vim.o.completeopt = 'menuone,noselect' -- Show completions in menu
vim.o.termguicolors = true -- Show da fancy colors
vim.o.textwidth = 100 -- Wrap lines after 100 characters
vim.o.colorcolumn = '-1' -- Line length indicator just before line will be split
vim.o.scrolloff = 15 -- Keep enough lines above and below the cursor at all times

-- ///////
-- KEYMAPS
-- ///////

-- Don't do anything else with the leader key
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Don't skip wrapped lines when scrolling
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Reset normal mode with Esc
vim.keymap.set('n', '<Esc>', ':noh<CR>zz')

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
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {
  desc = 'Open floating diagnostic message'
})
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Momentarily highlight yanked content
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- /////
-- THEME
-- /////

require('onedark').setup({ style = 'darker', transparent = true }) -- Make onedark awesomer
require('onedark').load()
local custom_lualine_theme = require('lualine.themes.onedark')
custom_lualine_theme.normal.b.bg = 'nil' -- Revert to transparent
custom_lualine_theme.normal.c.bg = 'nil' -- Revert to transparent
require('lualine').setup { options = { theme = custom_lualine_theme } }

-- /////////
-- TELESCOPE
-- /////////

-- Initialize telescope
local fb_actions = require "telescope._extensions.file_browser.actions"
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true
    },
  },
  extensions = {
    file_browser = {
      hijack_netrw = true, -- Use instead of NetRW
      hidden = { file_browser = true, folder_browser = true },
      mappings = {
        ["i"] = {
          ["<C-n>"] = fb_actions.create,
          ["<F2>"] = fb_actions.rename,
          ["<C-x>"] = fb_actions.move,
          ["<C-y>"] = fb_actions.copy,
          ["<C-d>"] = fb_actions.remove,
          ["<C-o>"] = fb_actions.open,
        },
        ["n"] = {
          ["n"] = fb_actions.create,
          ["<F2>"] = fb_actions.rename,
          ["x"] = fb_actions.move,
        },
      }
    }
  }
}

require("telescope").load_extension "file_browser"
pcall(require('telescope').load_extension, 'fzf') -- Enable telescope fzf native, if installed

vim.keymap.set('n', '<leader>sr', require('telescope.builtin').oldfiles, {
  desc = '[S]earch [R]ecently opened'
})
vim.keymap.set('n', '<leader>sb', require('telescope.builtin').buffers, {
  desc = '[S]earch open [B]uffers'
})
vim.keymap.set('n', '<leader>sc', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[S]earch [C]urrently open buffer' })
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, {
  desc = 'Search [G]it [F]iles'
})
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, {
  desc = '[S]earch [F]iles'
})
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, {
  desc = '[S]earch [H]elp'
})
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, {
  desc = '[S]earch current [W]ord'
})
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, {
  desc = '[S]earch by [G]rep'
})
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, {
  desc = '[S]earch [D]iagnostics'
})
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, {
  desc = '[S]earch [R]esume'
})

-- //////////
-- TREESITTER
-- //////////

-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    ensure_installed = {
      'bash',
      'c',
      'cpp',
      'go',
      'javascript',
      'lua',
      'python',
      'rust',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
    },

    auto_install = false, -- Don't install new languages unless I tell you

    highlight = { enable = true }, -- Obviously we want syntax highlighting
    indent = { enable = true }, -- Obviously we want auto-indenting
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>', -- Select a syntactic object with ctrl-space
        node_incremental = '<c-space>', -- Keep ascending the syntax tree with ctrl-space
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          ['aa'] = '@parameter.outer', -- [a]round [a]rgument
          ['ia'] = '@parameter.inner', -- [i]nside [a]rgument
          ['af'] = '@function.outer', -- [a]round [f]unction
          ['if'] = '@function.inner', -- [i]nside [f]unction
          ['ac'] = '@class.outer', -- [a]round [c]lass
          ['ic'] = '@class.inner', -- [i]nside [c]lass
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
  }
end, 0)

-- //// ////
-- FILE TREE
-- //// ////

vim.keymap.set(
  "n",
  "<leader>f",
  require "telescope".extensions.file_browser.file_browser,
  { desc = "[F]ile browser" }
)

-- ///
-- LSP
-- ///

--  Generate a bunch of LSP-specific keymaps when LSP attaches to a buffer
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
    '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- document existing key chains
require('which-key').register {
  ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
  ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
  ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
  ['<leader>h'] = { name = 'More git', _ = 'which_key_ignore' },
  ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
  ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
}

-- mason-lspconfig requires that these setup functions are called in this order before setting up
-- the servers.
require('mason').setup()
require('mason-lspconfig').setup()

-- Enable the following language servers
local servers = {
  -- clangd = {},
  -- gopls = {},
  pyright = {}, -- PYTHON, BABY!!!
  -- rust_analyzer = {},
  -- tsserver = {},
  -- html = { filetypes = { 'html', 'twig', 'hbs'} },

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
}

-- //// ///
-- NVIM-CMP
-- //// ///

local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs( -4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable( -1) then
        luasnip.jump( -1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
