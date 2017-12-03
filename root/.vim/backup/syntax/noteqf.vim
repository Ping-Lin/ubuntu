" Vim syntax file
" Language:    Note
" Version:     1.0
" Maintainer:  faelrevils@gmail.com
" Last Change: 2010.03.10 19:25

syntax clear

if version < 508
  command! -nargs=+ HiLink hi link <args>
else
  command! -nargs=+ HiLink hi def link <args>
endif
"set linebreak

" ============================ dokuwiki syntax ======================

syntax keyword	DokuTodo	TODO FIXME XXX Note
syntax match	DokuHeadLine1	/^\(=\{6\}\)[^=]\+\1/
syntax match	DokuHeadLine2	/^\(=\{5\}\)[^=]\+\1/
syntax match	DokuHeadLine3	/^\(=\{4\}\)[^=]\+\1/
syntax match	DokuHeadLine4	/^\(=\{3\}\)[^=]\+\1/
syntax match	DokuHeadLine5	/^\(=\{2\}\)[^=]\+\1/
syntax match	DokuList	/^\(  \)\+\(-\|\*\)/
syntax region	DokuInnerRef	start=+\[\[+ end=+\]\]+
syntax match	DokuInnerRefC	"\[\@<=[^\[]*[#:]" containedin=DokuInnerRef
syntax region	DokuMediaRef	start=+{{+ end=+}}+
syntax region	DokuCodeBlock	start=+<code[^>]*>+ end=+<\/code>+ fold contains=DokuTodo
syntax region	DokuFileBlock	start=+<file[^>]*>+ end=+<\/file>+ fold contains=DokuTodo
syntax region	DokuGraphvizBlock	start=+<graphviz[^>]*>+ end=+<\/graphviz>+ fold contains=DokuTodo
syntax region	DokuDitaaBlock	start=+<ditaa[^>]*>+ end=+<\/ditaa>+ fold contains=DokuTodo
syntax region	DokuHiddenBlock	start=+<hidden[^>]*>+ end=+<\/hidden>+ fold contains=DokuTodo
syntax match	DokuMono	"\\\@<!''[^']\+''"
syntax match	DokuBold	"\\\@<!\*\*[^\*]\+\*\*"

hi DokuHeadLine1	ctermfg=DarkMagenta
hi DokuHeadLine2	ctermfg=White
hi DokuHeadLine3	ctermfg=Yellow
hi DokuHeadLine4	ctermfg=Brown
hi DokuHeadLine5	ctermfg=Magenta
HiLink DokuTodo		Todo
HiLink DokuList		Label
HiLink DokuInnerRef	Identifier
HiLink DokuInnerRefC	Comment
HiLink DokuMediaRef	Identifier
HiLink DokuCodeBlock	Macro
HiLink DokuFileBlock	Macro
HiLink DokuGraphvizBlock	Macro
HiLink DokuDitaaBlock	Macro
HiLink DokuHiddenBlock	Macro
HiLink DokuMono		Type
HiLink DokuBold		String

" ============================ note =================================
syntax match	NoteComment	/^\s*#.*$/
syntax match	NoteShCmd	/^\s*>.*$/
syntax match	NoteVimCmd	/^\s*:.*$/
syntax region	NoteBold	start=+``+ end=+''+

HiLink NoteShCmd	Comment
HiLink NoteVimCmd	Function
HiLink NoteComment	Comment
HiLink NoteBold		Type

delcommand HiLink

map <buffer><C-m>	:let @z=@"<CR>$F l"xyw0<C-w><C-w>:<C-r>x<CR>:let @"=@z<CR>
