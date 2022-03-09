" --------------- GENERAL ---------------- "
" reload files changed outside of Vim not currently modified in Vim (needs below)
set autoread

" http://stackoverflow.com/questions/2490227/how-does-vims-autoread-work#20418591
au FocusGained,BufEnter * :silent! !

" use Unicode
set termencoding=utf-8
set encoding=utf-8

" make Backspace work like Delete
set backspace=indent,eol,start

" don't create `filename~` backups
set nobackup

" don't create temp files
set noswapfile

" disable modelines
set nomodeline

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

" gg moves to the start of line
set startofline


" ---------------- KEYS ----------------- "
" use ` as Leader
let mapleader="`"

" quick save all files
noremap <leader> :wall<CR>


" --------------- SPLITS ---------------- "
" default split locations
set splitbelow
set splitright


" --------------- TABS ------------------ "
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
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" custom highlights
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=#161616 guifg=NONE
highlight VertSplit cterm=NONE ctermfg=White ctermbg=NONE
highlight CursorLineNr guifg=white ctermfg=15 cterm=bold
highlight Whitespace ctermfg=236 guifg=grey19
highlight Pmenu ctermbg=238 guibg=#444444
highlight StatusLine ctermfg=233 guifg=#121212
highlight StatusLineNC ctermfg=233 guifg=#121212
highlight LineNr ctermfg=103 guifg=#555555


" ---------------- MISC ----------------- "
" remember cursor position
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" use netrw as file tree
let g:netrw_liststyle = 3
let g:netrw_winsize = 30
let g:netrw_banner=0
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+,\(^\|\s\s\)ntuser\.\S\+'
autocmd FileType netrw set nolist
nnoremap <C-b> :Lex<CR>
