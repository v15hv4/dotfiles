set background=dark
syntax enable           " enable syntax processing
set tabstop=4       " number of visual spaces per TAB
set shiftwidth=4
" set softtabstop=4   " number of spaces in tab when editing
set number              " show line numbers
set showcmd             " show command in bottom bar
set wildmenu            " visual autocomplete for command menu
set termguicolors
set expandtab
set cindent
se mouse+=v

" Clipboard shortcuts
map <C-c> "+y<CR>
map <C-v> "+p<CR>
map <C-x> dd
map <C-z> u

" Coderunner keybinding scripts
" Press F5 to run C code
map <F5> :w<CR>:silent !clear<CR><CR>:!gcc % -lm && ./a.out<CR>
" Press F6 to run C++ code
map <F6> :w<CR>:silent !clear<CR><CR>:!g++ % -lm && ./a.out<CR>
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
Plug 'thaerkh/vim-indentguides'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" Default Airline to molokai
let g:airline_theme='molokai'

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

" Disable dollarsigns at eol
set list listchars=

" Better intellisense suggestions colorscheme
highlight Pmenu ctermbg=238 guibg=#444444

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" Start Vim in Insert mode
startinsert
