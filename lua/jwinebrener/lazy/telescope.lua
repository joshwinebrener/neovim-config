return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make', -- NOTE: requires `make` installed on PC
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
}
