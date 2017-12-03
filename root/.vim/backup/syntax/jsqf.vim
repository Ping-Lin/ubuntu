" Vim syntax file
" Language:    jsqf
" Version:     1.0
" Maintainer:  faelrevils@gmail.com
" Last Change: 2010.04.27 16:14

syntax clear

if version < 508
  command! -nargs=+ HiLink hi link <args>
else
  command! -nargs=+ HiLink hi def link <args>
endif
set nowrap

syntax match	classline	/^\w.*$/ contains=extend,anchor,types
syntax match	funcline	/^  .*$/ contains=anchor
syntax match	extend		/<-[^\[]*/ contained
syntax match	anchor		/\[.*\]/ contained
syntax match	types		/{.*}/ contained
syntax match	fileline	/^file: .*$/


HiLink fileline		Label
HiLink funcline		Function
HiLink classline	Type
HiLink extend		Comment
HiLink anchor		Include
HiLink types		Comment

delcommand HiLink

map <buffer><C-m>	:let @z=@"<CR>$b"xyi[^<C-w><C-w>:<C-r>x<CR>zt:let @"=@z<CR>
