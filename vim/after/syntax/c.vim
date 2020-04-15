" Colorize C operators
syntax match mySpecialSymbols "+\|-\|\*\|?\|:\|<\|>\|&\||\|!\|\~\|%\|="
hi def link mySpecialSymbols PreProc

" Colorize escape sequences
syn match   cSpecial    display contained "\\\(x\x\+\|\o\{1,3}\|.\|$\)"
syn region  cString     start=+\(L\|u\|u8\|U\|R\|LR\|u8R\|uR\|UR\)\="+ skip=+\\\\\|\\"+ end=+"+ contains=cSpecial,cFormat,@Spell extend
hi cSpecial ctermfg=203
hi def link cSpecial PreProc

" Highlight Class and Function names
syn match    cCustomParen    "(" contains=cParen,cCppParen
syn match    cCustomFunc     "\w\+\s*(" contains=cCustomParen
syn match    cCustomScope    "::"
syn match    cCustomClass    "\w\+\s*::" contains=cCustomScope

hi def link cCustomFunc  Function
hi def link cCustomClass Function
