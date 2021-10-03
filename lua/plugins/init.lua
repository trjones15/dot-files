local pwd = 'plugins.'
local config_pwd = pwd..'configs.'

require(pwd..'plugin-manager')

attach_func = require(config_pwd..'nvim-lspconfig')
require(config_pwd..'nvim-cmp')
require(config_pwd..'nvim-tree')
require(config_pwd..'nvim-treesitter')
require(config_pwd..'telescope')
require(config_pwd..'telescope-fzf-native')

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local nvim_lsp = require('lspconfig')
local servers = { 'pyright', 'gopls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = attach_func,
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  }
end
