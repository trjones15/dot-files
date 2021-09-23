local opt = vim.opt
local cmd = vim.cmd

-- Display
opt.ruler = true

-- Color
cmd 'colorscheme gruvbox'

-- Numbering
opt.number = true
opt.relativenumber = true

-- Highlighting
opt.syntax = 'on'
opt.cursorline = true

-- Tab Conversion
opt.smarttab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- Encoding
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'

-- Copy/Paste
opt.shada = "'100,<1000,s1000,/100" -- '<the number of marks that are saved>,<the number of lines in a register>,<specify the maximum size of an item's content in KiB>,<number of search patterns stored>
opt.clipboard = 'unnamed,unnamedplus'

-- Message/Error Alerts
opt.shortmess:append('c')

-- TODO: Write diff with saved in lua and assign keymap
