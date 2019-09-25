" Colorize C operators
syntax match mySpecialSymbols "+\|-\|\*\|?\|:\|<\|>\|&\||\|!\|\~\|%\|="
hi mySpecialSymbols ctermfg=208

" Highlight Class and Function names
syn match    cCustomParen    "(" contains=cParen,cCppParen
syn match    cCustomFunc     "\w\+\s*(" contains=cCustomParen
syn match    cCustomScope    "::"
syn match    cCustomClass    "\w\+\s*::" contains=cCustomScope

hi def link cCustomFunc  Function
hi def link cCustomClass Function
