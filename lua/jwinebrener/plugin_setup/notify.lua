local notify = require 'notify'
notify.setup {
  setup_config = {
    background_colour = '#000000',
  },
}
vim.notify = notify
