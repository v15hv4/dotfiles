" Set
set background=dark
set encoding=utf8
set tabstop=4
set shiftwidth=4
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
set nocompatible
set noshowmode
set hlsearch
set list

" Let
let g:gruvbox_contrast_dark='hard'
let g:airline_powerline_fonts = 1
let g:gruvbox_italic = 1
let g:airline_theme='deus'
let &t_ut=''

" Theme
colorscheme gruvbox_mod
syntax enable

" Keymaps
let mapleader="`"
noremap <leader> :wall<CR>:qall!<CR>
noremap <F1> :qall!<CR>
noremap <F5> :w<CR>:call SendKeys()<CR>
nmap <C-b> :NERDTreeToggle<CR>
nmap <C-Left> :tabprevious<CR>
nmap <C-Right> :tabnext<CR>
nmap qf  <Plug>(coc-fix-current)
nmap qd  <Plug>(coc-definition)

" Floaterm config
let g:floaterm_keymap_toggle = '<C-w>'
let g:floaterm_width = 0.3
let g:floaterm_height = 0.8
let g:floaterm_position = 'topright'
let g:floaterm_wintitle = v:false

" Highlights
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=#161616 guifg=NONE
highlight VertSplit cterm=NONE ctermfg=White ctermbg=NONE
highlight CursorLineNr guifg=white ctermfg=15 cterm=bold
highlight SpecialKey ctermfg=238 guifg=grey27
highlight Pmenu ctermbg=238 guibg=#444444
highlight LineNr ctermfg=242

" Plug
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'voldikss/vim-floaterm'
call plug#end()

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
filetype off
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'jiangmiao/auto-pairs'
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
		autocmd BufNewFile *.cpp 0r ~/.vim/templates/skeleton.cpp | :7 | startinsert
	augroup END
endif

" Remember cursor position
if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Run code
function SendKeys()
	if expand('%:e') == "c"
			call floaterm#run('new', "gcc " . expand('%') . " -lm && ./a.out")
		elseif expand('%:e') == "cpp"
			call floaterm#run('new', "g++ " . expand('%') . " && ./a.out")
		elseif expand('%:e') == "py"
			call floaterm#run('new', "python " . expand('%'))
	endif
endfunction

