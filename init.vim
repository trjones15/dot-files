
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd!
  autocmd VimEnter * PlugInstall
endif

"Initialize Plugin System
"-----------
call plug#begin('~/.vim/plugged') "Specify a directory for plugins

"Language Server Protocol
"-----------
"Try using the built-in LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}


"Language Specific Plugins
"-----------
"Language Specific Plugins - Golang
Plug 'fatih/vim-go'


"File System Navigation
"-----------
Plug 'scrooloose/nerdtree' " shows file directory to the left
Plug 'Xuyuanp/nerdtree-git-plugin' " Shows git status flags for files and folders in NERDTree
"syntax highlighter made NERDTree navigation painfully slow
"Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " Adds syntax highlighting to NERDTree based on filetype
"According to vim-devicons, you need to install it last
"Plug 'ryanoasis/vim-devicons' " adds file specific icons to NERDTree files and folders
Plug 'airblade/vim-gitgutter' " shows git diff in the sign column
Plug 'ctrlpvim/ctrlp.vim' " fuzzy find files


"Text Manipulation
"-----------
Plug 'scrooloose/nerdcommenter'

"General Vim Plugin
"-----------
Plug 'morhetz/gruvbox'
Plug 'nvim-treesitter/nvim-treesitter' , {'do': ':TSUpdate'} " requires languages to be installed :TSInstall python, :TSInstall go
Plug 'vim-airline/vim-airline'
Plug 'vim-ariline/vim-airline-themes'

"vim-devicons says it needs to be the last plugin installed
Plug 'ryanoasis/vim-devicons' " adds file specific icons to NERDTree files and folders
call plug#end()



"General Vim Configurations
"-----------
:let mapleader = "\<Space>"

:set hidden " *Not my Comment* if hidden is not set, TextEdit might fail. Some servers have issues with backup files, see #649 set nobackup set nowritebackup 
:set updatetime=300 " *Not my Comment* You will have bad experience for diagnostic messages when it's default 4000.
:set timeoutlen=500

"FONT
"-----------
:set guifont=Hack

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
"Plugin - Language Server Protocol Config - coc.nvim
"-----------
:set nobackup "This is recommended by coc
:set nowritebackup "This is recommended by coc
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-go',
  \ 'coc-pyright'
  \ ]

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


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
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
"Plugin - Text Manipulation
"-----------
"Plugin - Text Manipulation - nerd-commenter
"-----------
filetype plugin on
vmap <C-_> <plug>NERDCommenterToggle<CR>gv " <C-_> is the vim version for <C-/>
nmap <C-_> <plug>NERDCommenterToggle " <C-_> is the vim version for <C-/>

"Plugin - General Vim Plugin - nvim-treesitter
"-----------
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "go", "python" },     -- one of "all", "language", or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
  },
}
EOF
