local fterm = require 'FTerm'
opts = { border = 'rounded' }
if vim.fn.has 'win32' then
  opts.cmd = 'powershell.exe'
end
require('FTerm').setup (opts)
vim.keymap.set('n', '<leader>t', fterm.toggle, { desc = '[T]erminal' })
