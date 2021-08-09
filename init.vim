if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd!
  autocmd VimEnter * PlugInstall
endif

"Initialize Plugin System
"-----------
" Plugins are installed by running :PlugInstall in Normal mode
" Plugins can be cleaned up by running :PlugClean in Normal mode

call plug#begin('~/.vim/plugged') "Specify a directory for plugins

"Language Server Protocol
"-----------
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
"Plug 'glepnir/lspsaga.nvim' not sure if needed but could help the UI

"Language Specific Plugins
"-----------
"Language Specific Plugins - Golang
"Plug 'fatih/vim-go'


"File System Navigation
"-----------
Plug 'scrooloose/nerdtree' " shows file directory to the left
Plug 'Xuyuanp/nerdtree-git-plugin' " Shows git status flags for files and folders in NERDTree
"syntax highlighter made NERDTree navigation painfully slow
"Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " Adds syntax highlighting to NERDTree based on filetype
"According to vim-devicons, you need to install it last
"Plug 'ryanoasis/vim-devicons' " adds file specific icons to NERDTree files and folders
Plug 'airblade/vim-gitgutter' " shows git diff in the sign column
"Plug 'ctrlpvim/ctrlp.vim' " fuzzy find files
"better fuzzy finding
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'


"Text Manipulation
"-----------
Plug 'scrooloose/nerdcommenter'

"General Vim Plugin
"-----------
Plug 'morhetz/gruvbox' "color scheme
Plug 'nvim-treesitter/nvim-treesitter' , {'do': ':TSUpdate'} " enhanced syntax highlighter - requires languages to be installed :TSInstall python, :TSInstall go
Plug 'vim-airline/vim-airline'
"Plug 'vim-ariline/vim-airline-themes' wasn't working with PlugInstall

"vim-devicons says it needs to be the last plugin installed
    " Steps to make work... 
    " 1.1 Go to nerd-fonts not in the WSL Ubuntu Shell not in the WSL Ubuntu
    " 1.2 Find a patched font not in the WSL Ubuntu Shell not in the WSL
    " 1.3 Download and install the patched font in windows... not in the WSL Ubuntu Shell
    " 2.1 In Windows, open up the terminal and go to the Ubuntu settings
    " 2.2 Find fonts and select the patched nerd-font that you installed
Plug 'ryanoasis/vim-devicons' " adds file specific icons to NERDTree files and folders
call plug#end()


"General Vim Configurations
"-----------
:let mapleader = "\<Space>"

:set hidden " *Not my Comment* if hidden is not set, TextEdit might fail. Some servers have issues with backup files, see #649 set nobackup set nowritebackup 
:set updatetime=300 " *Not my Comment* You will have bad experience for diagnostic messages when it's default 4000.
:set timeoutlen=500

"MAPPINGS
"-----------
:noremap <leader>gb <C-o> "go backwards in jumps
:noremap <leader>gf <C-i> "go forward in jumps
:inoremap jk <Esc>
:inoremap kj <Esc>

"FONT
"-----------
":set guifont=Htestack\ Regular\ Nerd\ Font\ Complete\ 12 not needed since font is set at the WSL level

"DISPLAY
"-----------
:set nowrap " Display long lines as just one line
:set cmdheight=2 " *Not my Comment* Better display for messages
:set pumheight=10 " Makes popup menus smaller
:set signcolumn=yes
:set ruler
:set splitbelow
:set splitright
:set laststatus=0

"ENCODING
"-----------
:set encoding=utf-8
:set fileencoding =utf-8

"COPY/PASTE:
"-----------
:set viminfo='100,<1000,s10,h "Increases the memory limit from 50 lines to 1000 lines
:set clipboard=unnamedplus

"NUMBERING:
"----------
:set relativenumber
:set nu rnu

"HIGHLIGHTING
"------
:syntax on
:set cursorline 
":set cursorcolumn

"COLOR:
"------
:colorscheme gruvbox
:set background=dark
:set t_Co=256

"TAB CONVERSION:
"------
:set smarttab
:set tabstop=4
:set shiftwidth=4
:set expandtab

"MESSAGES/ERROR ALERT:
"------
set shortmess+=c " don't give #c->ins-completion-menu# messages.

"Plugin Configurations
"-----------
"Plugin - Language Server Protocol Config
"-----------
"Plugin - Language Server Protocol Config - nvim.lspconfig
"-----------
"Configure the right LSP based on Config file https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
lua << EOF
require'lspconfig'.pyright.setup{}
require'lspconfig'.gopls.setup{}
EOF
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "pyright", "gopls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF
"Plugin - Language Server Protocol Config - nvim-compe
"-----------
lua << EOF
vim.o.completeopt = "menuone,noselect"

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = false;

  source = {
    path = true;
    buffer = true;
    calc = true;
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    snippets_nvim = true;
    treesitter = true;
  };
}
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF
"lua << EOF
"require'compe'.setup {
  "enabled = true;
  "autocomplete = true;
  "debug = false;
  "min_length = 1;
  "preselect = 'enable';
  "throttle_time = 80;
  "source_timeout = 200;
  "resolve_timeout = 800;
  "incomplete_delay = 400;
  "max_abbr_width = 100;
  "max_kind_width = 100;
  "max_menu_width = 100;
  "documentation = {
    "border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    "winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    "max_width = 120,
    "min_width = 60,
    "max_height = math.floor(vim.o.lines * 0.3),
    "min_height = 1,
  "};

  "source = {
    "path = true;
    "buffer = true;
    "calc = true;
    "nvim_lsp = true;
    "nvim_lua = true;
    "vsnip = true;
    "ultisnips = true;
    "luasnip = true;
  "};
"}
"EOF
"inoremap <silent><expr> <C-Space> compe#complete()
"inoremap <silent><expr> <CR>      compe#confirm('<CR>')
"inoremap <silent><expr> <C-e>     compe#close('<C-e>')
"inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
"inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

"Plugin - Language Server Protocol Config - coc.nvim
"-----------
":set nobackup "This is recommended by coc
":set nowritebackup "This is recommended by coc
"let g:coc_global_extensions = [
  "\ 'coc-snippets',
  "\ 'coc-pairs',
  "\ 'coc-go',
  "\ 'coc-pyright'
  "\ ]

"" Use tab for trigger completion with characters ahead and navigate.
"" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
"inoremap <silent><expr> <TAB>
      "\ pumvisible() ? "\<C-n>" :
      "\ <SID>check_back_space() ? "\<TAB>" :
      "\ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"function! s:check_back_space() abort
  "let col = col('.') - 1
  "return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

"" Use <c-space> to trigger completion.
"inoremap <silent><expr> <c-space> coc#refresh()

"" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
"" Coc only does snippet and additional edit on confirm.
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"" Or use `complete_info` if your vim support it, like:
"" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

"" Use `[g` and `]g` to navigate diagnostics
"nmap <silent> [g <Plug>(coc-diagnostic-prev)
"nmap <silent> ]g <Plug>(coc-diagnostic-next)

"" Remap keys for gotos
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)

"" Use K to show documentation in preview window
"nnoremap <silent> K :call <SID>show_documentation()<CR>

"function! s:show_documentation()
  "if (index(['vim','help'], &filetype) >= 0)
    "execute 'h '.expand('<cword>')
  "else
    "call CocAction('doHover')
  "endif
"endfunction

"" Highlight symbol under cursor on CursorHold
"autocmd CursorHold * silent call CocActionAsync('highlight')

"" Remap for rename current word
"nmap <F2> <Plug>(coc-rename)

"" Remap for format selected region
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)

"" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
"xmap <leader>a  <Plug>(coc-codeaction-selected)
"nmap <leader>a  <Plug>(coc-codeaction-selected)

"" Remap for do codeAction of current line
"nmap <leader>ac  <Plug>(coc-codeaction)
"" Fix autofix problem of current line
"nmap <leader>qf  <Plug>(coc-fix-current)

"" Create mappings for function text object, requires document symbols feature of languageserver.
"xmap if <Plug>(coc-funcobj-i)
"xmap af <Plug>(coc-funcobj-a)
"omap if <Plug>(coc-funcobj-i)
"omap af <Plug>(coc-funcobj-a)

"" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
"nmap <silent> <C-d> <Plug>(coc-range-select)
"xmap <silent> <C-d> <Plug>(coc-range-select)

"" Use `:Format` to format current buffer
"command! -nargs=0 Format :call CocAction('format')

"" Use `:Fold` to fold current buffer
"command! -nargs=? Fold :call     CocAction('fold', <f-args>)

"" use `:OR` for organize import of current buffer
"command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

"" Add status line support, for integration with other plugin, checkout `:h coc-status`
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"" Using CocList
"" Show all diagnostics
"nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
"" Manage extensions
"nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
"" Show commands
"nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
"" Find symbol of current document
"nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
"" Search workspace symbols
"nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
"" Do default action for next item.
"nnoremap <silent> <space>j  :<C-u>CocNext<CR>
"" Do default action for previous item.
"nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
"" Resume latest coc list
"nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


"Plugin - File System Navigation
"-----------
"Plugin - File System Navigation - nerdtree
"-----------
nmap <C-n> :NERDTreeToggle<CR>
" open NERDTree automatically
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * NERDTree

let g:NERDTreeGitStatusWithFlags = 1
"let g:WebDevIconsUnicodeDecorateFolderNodes = 1
"let g:NERDTreeGitStatusNodeColorization = 1
"let g:NERDTreeColorMapCustom = {
    "\ "Staged"    : "#0ee375",  
    "\ "Modified"  : "#d9bf91",  
    "\ "Renamed"   : "#51C9FC",  
    "\ "Untracked" : "#FCE77C",  
    "\ "Unmerged"  : "#FC51E6",  
    "\ "Dirty"     : "#FFBD61",  
    "\ "Clean"     : "#87939A",   
    "\ "Ignored"   : "#808080"   
    "\ }                         

" NERDTrees File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('md', 'yellow', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('go', 'Magenta', 'none', '#ff00ff', '#151515')
call NERDTreeHighlightFile('py', 'Blue', 'none', '#ff00ff', '#151515')
call NERDTreeHighlightFile('ds_store', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('gitconfig', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('gitignore', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('bashrc', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('bashprofile', 'Gray', 'none', '#686868', '#151515')

autocmd VimEnter * NERDTree | wincmd p " Start NERDTree and put the cursor back in the other window.

autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif " Exit Vim if NERDTree is the only window remaining in the only tab.

autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif " Close the tab if NERDTree is the only window remaining in it.

nnoremap <C-n> :NERDTreeMirror<CR>:NERDTreeFocus<CR> " Mirror the NERDTree before showing it. This makes it the same on all tabs.

"function! IsNERDTreeOpen()        
"  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
"endfunction
"
" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
"function! SyncTree()
"  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
"    NERDTreeFind
"    wincmd p
"  endif
"endfunction
"
"" Highlight currently open buffer in NERDTree
" autocmd BufEnter * call SyncTree()

"Plugin - File System Navigation - nerdtree-git-plugin
"-----------
"Plugin - File System Navigation - vim-nerdtree-syntax-highlight
"-----------
:set lazyredraw

"Plugin - File System Navigation - vim-devicons
"-----------
"Plugin - File System Navigation - vim-gitgutter
"-----------
"Plugin - File System Navigation - ctrlp.vim
"-----------
"let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

"Plugin - File System Navigation - telescope
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr> "need ripgrep to make work install with: sudo apt-get install ripgrep
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

lua <<EOF
require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    path_display = {},
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  }
}
EOF
"Plugin - Text Manipulation
"-----------
"Plugin - Text Manipulation - nerd-commenter
"-----------
filetype plugin on
vmap <C-_> <plug>NERDCommenterToggle<CR>gv " <C-_> is the vim version for <C-/>
nmap <C-_> <plug>NERDCommenterToggle " <C-_> is the vim version for <C-/>

"Plugin - General Vim Plugin - nvim-treesitter
"-----------
:set textwidth=0
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "go", "python" },     -- one of "all", "language", or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
  },
}
EOF
