
syn match myString /'[^']*'/ contains=myWord,myVim
syn match myWord   /\<[a-z]*\>/ contained
syn match myVim    /\<vim\>/ transparent contained contains=NONE
hi link myString String
hi link myWord   Comment
