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
vim.keymap.set(
	"n",
	"<leader>f",
	require "telescope".extensions.file_browser.file_browser,
	{ desc = "[F]ile browser" }
)
