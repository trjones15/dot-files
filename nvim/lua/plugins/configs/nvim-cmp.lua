-- Setup nvim-cmp.
local cmp = require('cmp')
local mapping = require('mappings.nvim-cmp')

require("luasnip.loaders.from_vscode").lazy_load({paths = {"~/.config/nvim/lua/plugins/configs/snippets"}})

cmp.setup({
  mapping = mapping,
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  }),
})
