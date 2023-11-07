-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    ensure_installed = {
      'bash',
      'c',
      'cpp',
      'go',
      'javascript',
      'lua',
      'python',
      'rust',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
    },

    auto_install = false, -- Don't install new languages unless I tell you

    highlight = { enable = true }, -- Obviously we want syntax highlighting
    indent = { enable = true }, -- Obviously we want auto-indenting
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>', -- Select a syntactic object with ctrl-space
        node_incremental = '<c-space>', -- Keep ascending the syntax tree with ctrl-space
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          ['aa'] = '@parameter.outer', -- [a]round [a]rgument
          ['ia'] = '@parameter.inner', -- [i]nside [a]rgument
          ['af'] = '@function.outer', -- [a]round [f]unction
          ['if'] = '@function.inner', -- [i]nside [f]unction
          ['ac'] = '@class.outer', -- [a]round [c]lass
          ['ic'] = '@class.inner', -- [i]nside [c]lass
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
  }
end, 0)
