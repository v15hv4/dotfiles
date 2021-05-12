
"         ________ ++     ________
"        /VVVVVVVV\++++  /VVVVVVVV\
"        \VVVVVVVV/++++++\VVVVVVVV/
"         |VVVVVV|++++++++/VVVVV/'
"         |VVVVVV|++++++/VVVVV/'
"        +|VVVVVV|++++/VVVVV/'+
"      +++|VVVVVV|++/VVVVV/'+++++
"    +++++|VVVVVV|/VVVVV/'+++++++++
"      +++|VVVVVVVVVVV/'+++++++++
"        +|VVVVVVVVV/'+++++++++
"         |VVVVVVV/'+++++++++
"         |VVVVV/'+++++++++
"         |VVV/'+++++++++
"         'V/'   ++++++
"                  ++


" --------------- GENERAL ---------------- "
" reload files changed outside of Vim not currently modified in Vim (needs below)
set autoread

" http://stackoverflow.com/questions/2490227/how-does-vims-autoread-work#20418591
au FocusGained,BufEnter * :silent! !

" use Unicode
set encoding=utf-8

" make Backspace work like Delete
set backspace=indent,eol,start

" don't create `filename~` backups
set nobackup

" don't create temp files
set noswapfile

" tab config
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

" show line numbers
set number

" show cursor line
set cursorline

" highlight matching parens, braces, brackets, etc
set showmatch

" make scrolling and painting fast
set ttyfast lazyredraw

" http://vim.wikia.com/wiki/Searching
set hlsearch incsearch ignorecase smartcase

" Use system clipboard
set clipboard=unnamed

" fold on markers
set foldmethod=marker

" don't wrap lines
set nowrap

" ---------------- KEYS ----------------- "
" use ` as Leader
let mapleader="`"

" quick save all files
noremap <leader> :wall<CR>


" --------------- SPLITS ---------------- "
" default split locations
set splitbelow
set splitright

" navigating splits
nnoremap <C-Up> <C-W><C-Up>
nnoremap <C-Down> <C-W><C-Down>
nnoremap <C-Right> <C-W><C-L>
nnoremap <C-Left> <C-W><C-H>


" ---------------- TABS ----------------- "
" navigating tabs
nnoremap <M-Right> :tabn<CR>
nnoremap <M-Left> :tabp<CR>


" --------------- COLORS ---------------- "
" use a modified gruvbox theme
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_italic = 1
colorscheme gruvbox_mod
syntax enable
set termguicolors
set background=dark

" custom highlights
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=#161616 guifg=NONE
highlight VertSplit cterm=NONE ctermfg=White ctermbg=NONE
highlight CursorLineNr guifg=white ctermfg=15 cterm=bold
highlight Whitespace ctermfg=236 guifg=grey19
highlight Pmenu ctermbg=238 guibg=#444444
highlight LineNr ctermfg=242


" ---------------- PLUG ----------------- "
call plug#begin('~/.vim/plugged')
" general purpose
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'

" nerdtree & co
Plug 'preservim/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'

" syntax highlighting
Plug 'pangloss/vim-javascript'
Plug 'vim-python/python-syntax'
Plug 'maxmellon/vim-jsx-pretty'
call plug#end()


" -------------- NERDTREE --------------- "
nnoremap <C-b> :NERDTreeTabsToggle<CR>


" -------------- GITGUTTER -------------- "
" basic config
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_enabled = 1
let g:gitgutter_map_keys = 0

" color tweaks
hi clear SignColumn
hi link GitGutterAdd GruvboxOrange
hi link GitGutterChange GruvboxBlue
hi link GitGutterChangeDeleteLine GruvboxYellow
hi GitGutterDelete ctermfg=203 guifg=#ff5f5f


" ---------------- MISC ----------------- "
" remember cursor position
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
