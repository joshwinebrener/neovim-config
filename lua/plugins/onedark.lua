return {
  'navarasu/onedark.nvim',
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'onedark'
    require('onedark').setup {
      style = 'darker',
      transparent = true,
    }
    require('onedark').load()
  end,
}
