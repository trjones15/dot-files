local map = vim.api.nvim_set_keymap

map('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap = true})
map('n', '<Leader>r', ':NvimTreeRefresh<CR>', {noremap = true})
map('n', '<Leader>lf', ':NvimTreeFindFile<CR>', {noremap = true})
