" Colorize C++ extraction and insertion operators
syntax match outOps "<<\|>>"
hi def link outOps Function
hi Boolean guifg=#ff5f5f ctermfg=203
syn keyword cType class
syn keyword cType struct
syn keyword cType public
syn keyword cType protected
syn keyword cType private
syn match cType ":"
syn keyword cType namespace
