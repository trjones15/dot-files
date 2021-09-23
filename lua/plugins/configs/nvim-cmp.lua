-- Setup nvim-cmp.
local cmp = require('cmp')
local mapping = require('mappings.nvim-cmp')
local servers = require('plugins.configs.nvim-lspconfig')

cmp.setup({
    snippet = {
      expand = function(args)
        -- For `vsnip` user.
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.
      end,
    },
    mapping = mapping,
    sources = {
      { name = 'nvim_lsp' },

      -- For vsnip user.
      { name = 'vsnip' },

      { name = 'buffer' },
    }
})

-- Setup lspconfig.
for _, server in ipairs(servers) do
require('lspconfig')[server].setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
}
end
