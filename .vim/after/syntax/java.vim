" highlight operators
syntax match _Operator "[-+&|<>=!\/~.,;:*%&^?()\[\]]"

" highlight methods
syntax match _Paren "?=(" contains=cParen,cCppParen
syntax match _memberFunc "\.\s*\w\+\s*(\@=" contains=_Operator,_Paren

" colors
hi _memberFunc guifg=#FF8700 guibg=NONE gui=none
hi _Operator guifg=#FF8700 guibg=NONE gui=none

" to resolve conflict with comment markers
syntax region _Comment start="\/\*" end="\*\/"
syntax match _Comment "\/\/.*$"
hi link _Comment Comment
