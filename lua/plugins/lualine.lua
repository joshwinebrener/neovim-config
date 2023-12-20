return {
  'nvim-lualine/lualine.nvim',
  config = function()
    local custom_lualine_theme = require 'lualine.themes.onedark'
    custom_lualine_theme.normal.b.bg = 'nil'
    custom_lualine_theme.normal.c.bg = 'nil'
    require 'lualine'.setup(
      {
        options = {
          theme = custom_lualine_theme
        }
      }
    )
  end
}
