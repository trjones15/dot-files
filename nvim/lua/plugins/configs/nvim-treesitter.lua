require'nvim-treesitter.configs'.setup {
  ensure_installed = { "go", "python" },     -- one of "all", "language", or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    additional_vim_regex_highlighting = false,
  },
}

-- customizable with https://neovim.io/doc/user/treesitter.html
vim.cmd 'hi @variable.go guifg=NavajoWhite2'
vim.cmd 'hi @parameter.go guifg=NavajoWhite2'

