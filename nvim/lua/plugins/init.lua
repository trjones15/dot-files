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

vim.lsp.config('*', {
    on_attach = attach_func,
    flags = {
      debounce_text_changes = 150,
    },
})

vim.lsp.config('gopls', {
  cmd = { '/Users/tjones/.asdf/shims/gopls' },
})

vim.lsp.enable({"gopls", "pyright", "vimls"})
