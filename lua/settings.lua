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
