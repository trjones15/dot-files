local map = vim.api.nvim_set_keymap

map('i', '<C-c>]', '<Plug>(copilot-next)', {noremap = true})
map('i', '<C-c>[', '<Plug>(copilot-previous)', {noremap = true})
map('i', '<C-c>;', '<Plug>(copilot-dismiss)', {noremap = true})
map('i', '<C-c><CR>', '<Plug>(copilot-accept)', {noremap = true})

