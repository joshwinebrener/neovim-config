local custom_lualine_theme = require 'lualine.themes.onedark'
custom_lualine_theme.normal.b.bg = 'nil' -- Revert to transparent
custom_lualine_theme.normal.c.bg = 'nil' -- Revert to transparent
require('lualine').setup { options = { theme = custom_lualine_theme } }
