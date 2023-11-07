-- The whitespace settings everyone always changes

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

-- Momentarily highlight yanked content
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
