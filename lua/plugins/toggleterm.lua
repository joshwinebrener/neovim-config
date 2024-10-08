return {
  'akinsho/toggleterm.nvim',
  version = "*",
  opts = {},
  config = function()
    if vim.fn.has('win32') then
      local powershell_options = {
        shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell",
        shellcmdflag =
        "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
        shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
        shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
        shellquote = "",
        shellxquote = "",
      }

      for option, value in pairs(powershell_options) do
        vim.opt[option] = value
      end
    end

    vim.keymap.set(
      'n',
      '<leader>t',
      '<cmd>ToggleTerm<cr>',
      { desc = '[T]erminal' }
    )
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)

    require 'toggleterm'.setup {
      direction = 'float',
      float_opts = {
        border = 'curved'
      }
    }
  end
}
