require'lspconfig'.pyright.setup{}
require'lspconfig'.gopls.setup{}

local nvim_lsp = require('lspconfig')
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local mappings = require('mappings.nvim-lspconfig')
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "pyright", "gopls" }

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = mappings,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

return servers
