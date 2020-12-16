" Set
set background=dark
set encoding=utf8
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set number
set showcmd
set wildmenu
set termguicolors
set cindent
set cursorline
set mouse=a
set splitbelow
set splitright
set backspace=indent,eol,start
set guifont=Fira\ Code\ Medium\ Nerd\ Font
set fillchars=vert:│
set listchars=tab:\│\ 
set ttimeoutlen=50
set foldmethod=marker
set clipboard=unnamed
set nocompatible
set noshowmode
set hlsearch
set nowrap
set list
set ttimeoutlen=100
set autoread

" Let
let g:python_highlight_all = 1
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_enabled = 1
let g:gitgutter_map_keys = 0
let g:gruvbox_contrast_dark='hard'
let g:airline_powerline_fonts = 1
let g:gruvbox_italic = 1
let g:airline_theme='deus'
let g:tex_flavor = 'latex'
let &t_ut=''

" Commands
command! -nargs=0 Prettier :CocCommand prettier.formatFile
autocmd BufWritePost * call CompileOnSave() 

" Theme
colorscheme gruvbox_mod
syntax enable

" Keymaps
let mapleader="`"
inoremap jk <Esc>
nnoremap <C-b> :NERDTreeTabsToggle<CR>
noremap <leader> :wall<CR>
nmap <F1> :qall!<CR>
nmap <F5> :call RunCode()<CR>
noremap qw :call VTerminalOpen()<CR>
noremap qa :call HTerminalOpen()<CR>

" Navigating Splits
nnoremap <C-Up> <C-W><C-Up>
nnoremap <C-Down> <C-W><C-Down>
nnoremap <C-Right> <C-W><C-L>
nnoremap <C-Left> <C-W><C-H>

" Navigating Tabs
nnoremap <M-Right> :tabn<CR>
nnoremap <M-Left> :tabp<CR>

nmap qf  <Plug>(coc-fix-current)
nmap qd  <Plug>(coc-definition)

" Highlights
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=#161616 guifg=NONE
highlight VertSplit cterm=NONE ctermfg=White ctermbg=NONE
highlight CursorLineNr guifg=white ctermfg=15 cterm=bold
highlight Whitespace ctermfg=236 guifg=grey19
highlight Pmenu ctermbg=238 guibg=#444444
highlight LineNr ctermfg=242

" Plug
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'lervag/vimtex'
Plug 'vimlab/split-term.vim'
Plug 'pangloss/vim-javascript'
Plug 'vim-python/python-syntax'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'
Plug 'mattn/emmet-vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
call plug#end()

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
filetype off
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'alvan/vim-closetag'
call vundle#end()
filetype plugin indent on

" CoC-configs
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <Tab>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<Tab>" :
            \ coc#refresh()
set updatetime=300
set shortmess+=c
set nobackup
set nowritebackup
set hidden

" Skeletons
if has("autocmd")
    augroup templates
        autocmd BufNewFile *.sh 0r ~/.vim/templates/skeleton.sh | :2 | startinsert
        autocmd BufNewFile *.c 0r ~/.vim/templates/skeleton.c | :4 | startinsert
        autocmd BufNewFile *.cpp 0r ~/.vim/templates/skeleton.cpp | :8 | startinsert
        autocmd BufNewFile *.tex 0r ~/.vim/templates/skeleton.tex | :8 | startinsert
    augroup END
endif

" Remember cursor position
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Run code
function RunCode()
    let l:ext = expand('%:e')
    
    " Jobs that run on an external app
    if ext == "tex"
        call jobstart('zathura '.expand('%:r').'.pdf')
    elseif ext == "md"
        MarkdownPreview
    else
        " Jobs that run on a vim terminal buffer
        split

        if ext == "c"
            terminal gcc % -lm && ./a.out
        elseif ext == "cpp"
            terminal g++ % && ./a.out
        elseif ext == "py"
            terminal python %
        elseif ext == "m"
            terminal octave %
        elseif ext == "js"
            terminal node %
        endif

        set nonu
        set cursorline
        startinsert
    endif
endfunction

" Neovim Terminal
function VTerminalOpen()
    40VTerm 
    set nonu
    set nocursorline
endfunction

function HTerminalOpen()
    Term 
    set nonu
    set nocursorline
endfunction

" Git
hi clear SignColumn
hi link GitGutterAdd GruvboxOrange
hi link GitGutterChange GruvboxBlue
hi link GitGutterChangeDeleteLine GruvboxYellow
hi GitGutterDelete ctermfg=203 guifg=#ff5f5f

" AutoClose Tags
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.php,*.jsx,*.js"

" Auto-compile on save
function CompileOnSave()
    if expand('%:e') == "scss"
       silent !sass % %:r.css
    elseif expand('%:e') == "tex"
        silent !pdflatex %
    endif
endfunction

" Format JSONs
function FormatJSON()
    %!python -m json.tool
endfunction

" Markdown Preview config
let g:mkdp_browser = 'surf'
