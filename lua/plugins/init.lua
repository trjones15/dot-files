local pwd = 'plugins.'
local config_pwd = pwd..'configs.'

require(pwd..'plugin-manager')

require(config_pwd..'nvim-lspconfig')
require(config_pwd..'nvim-cmp')
require(config_pwd..'nvim-tree')
require(config_pwd..'telescope-fzf-native')
