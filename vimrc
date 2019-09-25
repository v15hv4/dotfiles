set background=dark
syntax enable           " enable syntax processing
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set number              " show line numbers
set showcmd             " show command in bottom bar
set wildmenu            " visual autocomplete for command menu
set termguicolors
se mouse+=v
map <C-c> "+y<CR>

" Coderunner keybinding scripts

" Press F5 to run C code
map <F5> :w<CR>:silent !clear<CR><CR>:!gcc -lm % && ./a.out<CR>
" Press F6 to run C++ code
map <F6> :w<CR>:silent !clear<CR><CR>:!g++ % && ./a.out<CR>
" Press F7 to run Java code
map <F7> :w<CR>:silent !clear<CR><CR>:!javac % && java %:r<CR>
" Press F8 to run Python code
map <F8> :w<CR>:silent !clear<CR><CR>:!python %<CR>

colorscheme d4rk

" Autocomplete parentheses
let g:xptemplate_brace_complete = '([{'
" enables a DSL (a Domain specific language) for your plugin configurations

call plug#begin('~/.vim/plugged')
" inside these 'call lines' you can write 'Plug' instructions
" that specify each plugin you want to install

Plug 'Raimondi/delimitMate'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

" Darken line numbers
highlight LineNr ctermfg=242

" Hide end-of-buffer tildes
highlight EndOfBuffer ctermfg=black ctermbg=black

" Highlight current line numbers
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
set cursorline
highlight CursorLine cterm=NONE

" Colorize C operators
syntax match mySpecialSymbols "+\|-\|\*\|?\|:\|<\|>\|&\||\|!\|\~\|%\|="
highlight mySpecialSymbols ctermfg=208
