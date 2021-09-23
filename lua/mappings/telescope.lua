local map = vim.api.nvim_set_keymap

map('n', '<Leader>ff', '<Cmd>Telescope find_files<CR>', {noremap = true})
map('n', '<Leader>fg', '<Cmd>Telescope live_grep<CR>', {noremap = true})
map('n', '<Leader>fb', '<Cmd>Telescope buffers<CR>', {noremap = true})
map('n', '<Leader>fh', '<Cmd>Telescope help_tags<CR>', {noremap = true})
map('n', '<Leader>fr', '<Cmd>Telescope git_files<CR>', {noremap = true})
map('n', '<Leader>fs', '<Cmd>Telescope grep_string<CR>', {noremap = true})
