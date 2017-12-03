" Vim syntax file
" Language:	generic configure file
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2005 Jun 20

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn keyword	confTodo	contained TODO FIXME XXX 
" Avoid matching "text#text", used in /etc/disktab and /etc/gettytab
syn match	confComment	"^#.*" contains=confTodo,rcsFolded
syn match	confComment	"\s#.*"ms=s+1 contains=confTodo,rcsFolded
syn region	confString	start=+"+ skip=+\\\\\|\\"+ end=+"+ oneline
syn region	confString	start=+'+ skip=+\\\\\|\\'+ end=+'+ oneline
syn region	rcsFolded	start='{{{' end='}}}' contained fold transparent
syn match	rcsProject	"^###.*"
syn match	rcsModify	"^ \?M\s"
syn match	rcsAdd		"^ \?A\s"
syn match	rcsUpdate	"^ \?U\s"
syn match	rcsPatch	"^ \?P\s"
syn match	rcsUntrack	"^??\s"
syn match	rcsRemove	"^ \?R\s"
syn match	rcsRemove	"^ \?D\s"
syn match	rcsConflict	"^ \?C\s"
syn match	rcsModifyRev	"^M[0-9.]\+\s"
syn match	rcsDiffRev	"^D[0-9.]\+\s"
syn match	confRCSFile	"^RCS file: .*$"

" Define the default highlighting.
" Only used when an item doesn't have highlighting yet
hi def link confComment	Comment
hi def link confTodo	Todo
hi def link confString	String
hi def link rcsProject	PreProc
hi def link rcsModify	Constant
hi def link rcsAdd	Type
hi def link rcsUpdate	Identifier
hi def link rcsPatch	Identifier
hi def link rcsUntrack	Statement
hi def link rcsRemove	PreProc
hi def link rcsConflict Error
hi def link rcsModifyRev Type
hi def link rcsDiffRev Type
hi def link confRCSFile	PreProc

let b:current_syntax = "uplist"

" vim: ts=8 sw=2
