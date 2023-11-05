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
