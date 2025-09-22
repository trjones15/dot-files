local pwd = 'plugins.'
local config_pwd = pwd..'configs.'

require(pwd..'plugin-manager')

attach_func = require(config_pwd..'nvim-lspconfig')
--require(config_pwd..'nvim-cmp')
require(config_pwd..'nvim-tree')
require(config_pwd..'copilot')
require(config_pwd..'nvim-treesitter')
require(config_pwd..'telescope')
require(config_pwd..'telescope-fzf-native')

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local nvim_lsp = require('lspconfig')
local servers = { 'pyright',  'vimls'}

nvim_lsp['gopls'].setup {
  on_attach = attach_func,
  flags = {
    debounce_text_changes = 150,
  },
  cmd = { '/home/tjones/.asdf/installs/golang/1.24.2/bin/gopls' },
}
--nvim_lsp['rust_analyzer'].setup {
--  on_attach = attach_func,
--  flags = {
--    debounce_text_changes = 150,
--  },
--  settings = {
--    ['rust-analyzer'] = {
--        cargo = { allFeatures = true },
--        check = { command = "clippy" },
--    },
--  },
--}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = attach_func,
    flags = {
      debounce_text_changes = 150,
    },
  }
end
