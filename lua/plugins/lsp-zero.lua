return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v3.x',
  dependencies = {
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/nvim-cmp',
    'L3MON4D3/LuaSnip',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
  },
  config = function()
    local servers = { 'lua_ls', 'rust_analyzer', 'ruff_lsp', 'gopls', 'html', 'tsserver' }
    local lsp_zero = require('lsp-zero')
    lsp_zero.on_attach(function(client, bufnr)
      lsp_zero.default_keymaps({ buffer = bufnr })
      lsp_zero.buffer_autoformat()
    end)
    require('mason').setup({})
    require('mason-lspconfig').setup({
      ensure_installed = servers,
      handlers = {
        lsp_zero.default_setup,
      },
    })
    lsp_zero.setup_servers(servers)

    local cmp = require('cmp')
    local cmp_action = require('lsp-zero').cmp_action()
    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp_action.luasnip_supertab(),
        ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
      })
    })
  end
}
