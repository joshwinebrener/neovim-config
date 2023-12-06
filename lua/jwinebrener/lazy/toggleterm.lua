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
  '<leader>tp',
  '<cmd>TermExec cmd="powershell.exe" name=Powershell<cr>',
  { desc = '[T]erminal [P]owershell' }
)

return {
  'akinsho/toggleterm.nvim',
  version = "*",
  opts = {
    direction = 'float',
    float_opts = {
      border = 'curved'
    }
  }
}
