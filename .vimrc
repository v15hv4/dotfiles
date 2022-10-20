
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

" gg moves to the start of line
set startofline

" don't show current mode on commandbar
set noshowmode

" faster updatetime
" set updatetime=750

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

" custom highlights
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=#161616 guifg=NONE
highlight VertSplit cterm=NONE ctermfg=White ctermbg=NONE
highlight CursorLineNr guifg=white ctermfg=15 cterm=bold
highlight Whitespace ctermfg=236 guifg=grey19
highlight Pmenu ctermbg=238 guibg=#444444
highlight StatusLine ctermfg=233 guifg=#121212
highlight StatusLineNC ctermfg=233 guifg=#121212
highlight LineNr ctermfg=103 guifg=#555555


" ---------------- PLUG ----------------- "
" run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.vim/plugged')

" general purpose
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'

" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'

" nvim tree
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

" syntax highlighting & language specific plugins
Plug 'pangloss/vim-javascript'
Plug 'vim-python/python-syntax'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'rhysd/vim-clang-format'
Plug 'jupyter-vim/jupyter-vim'

" statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'

" terminal
Plug 'voldikss/vim-floaterm'
call plug#end()


" -------------- NVIM TREE -------------- "
nnoremap <C-b> :NvimTreeToggle<CR>


" --------------- GITGUTTER -------------- "
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


" ---------------- CoC ------------------ "
" extensions
let g:coc_global_extensions = ['coc-tsserver', 'coc-prettier', 'coc-snippets', 'coc-json', 'coc-pyright', 'coc-clangd']

" coc-snippets config
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" custom keybindings
nmap ef <Plug>(coc-fix-current)
nmap ed <Plug>(coc-definition)

" coc-prettier config
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


" -------------- CLOSETAG --------------- "
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.php,*.jsx,*.js"


" -------------- FZF & RG --------------- "
" default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

nnoremap <C-f> :Files<CR>
nnoremap <C-_> :Rg<CR>

let g:fzf_tags_command = 'ctags -R'

" Border color
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }

let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
let $FZF_DEFAULT_COMMAND="rg --files --hidden"

" customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }


" get text in files with Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" ripgrep advanced
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" git grep
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)


" ------------- STATUSLINE -------------- "
let g:airline_theme = 'serene'
let g:airline_powerline_fonts = 1
let g:webdevicons_enable_airline_statusline = 0

" items
au User AirlineAfterInit  :let g:airline_section_b = airline#section#create(['%<', '%t', 'readonly',  'lsp_progress'])
au User AirlineAfterInit  :let g:airline_section_c = airline#section#create(['branch'])
au User AirlineAfterInit  :let g:airline_section_x = airline#section#create(['coc_current_function',  'coc_status', 'bookmark', 'scrollbar', 'tagbar', 'vista', 'gutentags', 'gen_tags', 'omnisharp', 'grepper'])
au User AirlineAfterInit  :let g:airline_section_y = airline#section#create(['%l:%v'])
au User AirlineAfterInit  :let g:airline_section_z = airline#section#create(['%{WebDevIconsGetFileTypeSymbol()}', ' ', 'filetype'])

" custom palette
let g:airline_theme_patch_func = 'AirlineThemePatch'
function! AirlineThemePatch(palette)
  if g:airline_theme == 'serene'
      " remove colors
      for colors in values(a:palette.normal)
          let colors[0] = '#eeeeee'
          let colors[1] = '#121212'
      endfor
      for colors in values(a:palette.normal_modified)
          let colors[0] = '#eeeeee'
          let colors[1] = '#121212'
      endfor
      for colors in values(a:palette.insert)
          let colors[0] = '#eeeeee'
          let colors[1] = '#121212'
      endfor
      for colors in values(a:palette.insert_modified)
          let colors[0] = '#eeeeee'
          let colors[1] = '#121212'
      endfor
      for colors in values(a:palette.replace)
          let colors[0] = '#eeeeee'
          let colors[1] = '#121212'
      endfor
      for colors in values(a:palette.replace_modified)
          let colors[0] = '#eeeeee'
          let colors[1] = '#121212'
      endfor
      for colors in values(a:palette.visual)
          let colors[0] = '#eeeeee'
          let colors[1] = '#121212'
      endfor
      for colors in values(a:palette.visual_modified)
          let colors[0] = '#eeeeee'
          let colors[1] = '#121212'
      endfor

      " status text color
      let a:palette['normal']['airline_a'][0] = '#98be65'
      let a:palette['insert']['airline_a'][0] = '#51afef'
      let a:palette['replace']['airline_a'][0] = '#ec5f67'
      let a:palette['visual']['airline_a'][0] = '#c678dd'

      " branch color
      let a:palette['normal']['airline_c'][0] = '#a9a1e1'
      let a:palette['normal_modified']['airline_c'][0] = '#a9a1e1'

      " filetype color
      let a:palette['normal']['airline_z'][0] = '#c678dd'
      let a:palette['insert']['airline_z'][0] = '#c678dd'
      let a:palette['visual']['airline_z'][0] = '#c678dd'
    endif
endfunction


" ---------------- TERMINAL ----------------- "
let g:floaterm_title = ''
let g:floaterm_borderchars = '─│─│╭╮╯╰'

" highlights
hi FloatermBorder guibg=#080808 guifg=#87bb7c

" keymaps
nnoremap tt :FloatermToggle<CR>


" ------------ CODE RUNNER ------------- "
function RunCode()
    let l:ext = expand('%:e')
    if ext == "c"
        FloatermNew gcc % -lm && ./a.out
    elseif ext == "cpp"
        FloatermNew g++ % && ./a.out
    elseif ext == "py"
        FloatermNew python %
    elseif ext == "m"
        FloatermNew octave %
    elseif ext == "js"
        FloatermNew node %
    elseif ext == "go"
        FloatermNew go run %
    elseif ext == "dart"
        FloatermNew dart %
    elseif ext == "tex"
        call jobstart('zathura '.expand('%:r').'.pdf')
    elseif ext == "ipy"
        call jobstart('jupyter-qtconsole')
        JupyterConnect
    endif
endfunction

" Run current file
nmap <F5> :call RunCode()<CR>


" -------------- JUPYTER ----------------- "
" edit .ipy files as .py
autocmd BufNewFile,BufRead *.ipy set filetype=python

" Enter to run cell
" nnoremap   :JupyterSendCell<CR><Esc>

" set conceal level
setlocal conceallevel=1
setlocal concealcursor=vic

" ---------------- MISC ----------------- "
" remember cursor position
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" file skeletons
if has("autocmd")
    augroup templates
        autocmd BufNewFile *.sh 0r ~/.vim/templates/skeleton.sh
        autocmd BufNewFile *.c 0r ~/.vim/templates/skeleton.c
        autocmd BufNewFile *.cpp 0r ~/.vim/templates/skeleton.cpp
        autocmd BufNewFile *.tex 0r ~/.vim/templates/skeleton.tex

        " parse special text in the templates after the read
        autocmd BufNewFile * %substitute#\[:VIM_EVAL:\]\(.\{-\}\)\[:END_EVAL:\]#\=eval(submatch(1))#ge
    augroup END
endif

" start netrw in tree liststyle
let g:netrw_liststyle = 3

" enable all Python syntax highlights
let g:python_highlight_all = 1

" clang format options
let g:clang_format#auto_format = 1
let g:clang_format#detect_style_file = 1
let g:clang_format#style_options = {
            \ "Standard" : "C++11",
            \ "ColumnLimit" : 100}

" auto limit linewidth in .md and .tex files
au BufRead,BufNewFile *.tex setlocal textwidth=100

" auto compile .tex files on save
au BufWritePost *.tex silent !docker run --rm -v $(pwd):/workdir danteev/texlive latexmk -pdf %

" toggle line wrapping
let g:wrapping_on = 0
function ToggleWrap()
    if g:wrapping_on == 1
        let g:wrapping_on = 0
        echo "wrapping off"
    else
        let g:wrapping_on = 1
        echo "wrapping on"
    endif
endfunction
command ToggleWrap :call ToggleWrap()
command TW ToggleWrap
