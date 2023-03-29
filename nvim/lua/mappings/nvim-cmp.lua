local cmp = require('cmp')
mapping = {
--      ['<Leader>d'] = cmp.mapping.scroll_docs(-4),
--      ['<Leader>u'] = cmp.mapping.scroll_docs(4),
--      ['<Leader>a'] = cmp.mapping.abort(),
      ['<Tab>'] = cmp.mapping.select_next_item(),
      ['<S-Tab>'] = cmp.mapping.select_prev_item(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
}

return mapping
