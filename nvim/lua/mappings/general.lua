local map = vim.api.nvim_set_keymap

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Escape key is now more accessible
map('i', 'jk', '<Esc>', {noremap = true})
map('i', 'kj', '<Esc>', {noremap = true})

map('v', 'jk', '<Esc>', {noremap = true})
map('v', 'kj', '<Esc>', {noremap = true})

-- Navigation between jumps
map('n', '<Leader>gb', '<C-o>', {noremap = true})
map('n', '<Leader>gf', '<C-i>', {noremap = true})

-- Turn off highlighting after a search
map('n', '<Leader>h', ':nohlsearch<CR>', {noremap = true})

-- Navigate between active windows
map('n', '<Leader>h', '<C-w>h', {noremap = true})
map('n', '<Leader>j', '<C-w>j', {noremap = true})
map('n', '<Leader>k', '<C-w>k', {noremap = true})
map('n', '<Leader>l', '<C-w>l', {noremap = true})
