
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
set updatetime=750

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
highlight StatusLine ctermfg=233 guifg=#121212
highlight StatusLineNC ctermfg=235 guifg=#262626
highlight LineNr ctermfg=242


" ---------------- PLUG ----------------- "
call plug#begin('~/.vim/plugged')
" general purpose
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'
Plug 'ryanoasis/vim-devicons'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'

" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'

" nerdtree & co
Plug 'preservim/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'

" syntax highlighting
Plug 'pangloss/vim-javascript'
Plug 'vim-python/python-syntax'
Plug 'maxmellon/vim-jsx-pretty'

" statusline
Plug 'hoob3rt/lualine.nvim'
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


" ---------------- CoC ------------------ "
" extensions
let g:coc_global_extensions = ['coc-tsserver', 'coc-prettier', 'coc-snippets', 'coc-json']

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
  \ 'ctrl-i': 'split',
  \ 'ctrl-s': 'vsplit' }

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

" get files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

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
" lualine config
lua <<EOF
local lualine = require 'lualine'

-- color table for highlights
local colors = {
  bg = '#121212',
  fg = '#eeeeee',
  yellow = '#ECBE7B',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#98be65',
  orange = '#FF8800',
  violet = '#a9a1e1',
  magenta = '#c678dd',
  blue = '#51afef',
  red = '#ec5f67'
}

local conditions = {
  buffer_not_empty = function() return vim.fn.empty(vim.fn.expand('%:t')) ~= 1 end,
  hide_in_width = function() return vim.fn.winwidth(0) > 80 end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end
}

-- config
local config = {
  options = {
    -- disable sections and component separators
    component_separators = "",
    section_separators = "",
    theme = {
      -- we are going to use lualine_c an lualine_x as left and
      -- right section. Both are highlighted by c theme .  So we
      -- are just setting default looks o statusline
      normal = {c = {fg = colors.fg, bg = colors.bg}},
      inactive = {c = {fg = colors.fg, bg = colors.bg}}
    }
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {}
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_v = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {}
  }
}

-- inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left {
  -- mode component
  function()
    -- auto change color according to neovims mode
    local mode_color = {
      n = colors.green,
      i = colors.blue,
      v = colors.red,
      [''] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [''] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ['r?'] = colors.cyan,
      ['!'] = colors.red,
      t = colors.red
    }

    local mode_name = {
	 n  = 'NORMAL',
	 no = 'N·OPERATOR PENDING',
	 v  = 'VISUAL',
	 V  = 'V·LINE',
	 [''] = 'V·BLOCK',
	 s  = 'SELECT',
	 S  = 'S·LINE',
	 [''] = 'S·BLOCK',
	 i  = 'INSERT',
	 R  = 'REPLACE',
	 Rv = 'V·REPLACE',
	 c  = 'COMMAND',
	 cv = 'VIM EX',
	 ce = 'EX',
	 r  = 'PROMPT',
	 rm = 'MORE',
	 ['r?'] = 'CONFIRM',
	 ['!']  = 'SHELL',
	}

    vim.api.nvim_command(
        'hi! LualineMode guifg=' .. mode_color[vim.fn.mode()] .. " guibg=" ..
            colors.bg)
    return mode_name[vim.fn.mode()]
  end,
  color = "LualineMode",
  left_padding = 1
}

ins_left {
  'filename',
  condition = conditions.buffer_not_empty,
  color = {fg = colors.fg, gui = 'bold'}
}

ins_left {
  'branch',
  icon = '',
  condition = conditions.check_git_workspace,
  color = {fg = colors.violet, gui = 'bold'}
}

-- insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left {function() return '%=' end}

ins_right {
  'diff',
  symbols = {added = ' ', modified = '柳', removed = ' '},
  color_added = colors.green,
  color_modified = colors.orange,
  color_removed = colors.red,
  condition = conditions.hide_in_width
}

ins_right {
  'diagnostics',
  sources = {'coc'},
  symbols = {error = ' ', warn = ' ', info = ' '},
  color_error = colors.red,
  color_warn = colors.yellow,
  color_info = colors.cyan
}

ins_right {
  'location',
  color = {fg = colors.fg, gui = 'bold'}
}

ins_right {
  'filetype',
  color = {fg = colors.magenta, gui = 'bold'}
}

ins_right {
  right_padding = 1
}

lualine.setup(config)
EOF


" ---------------- MISC ----------------- "
" remember cursor position
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" start netrw in tree liststyle
let g:netrw_liststyle = 3

" auto limit linewidth in .md files
au BufRead,BufNewFile *.md setlocal textwidth=75

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
