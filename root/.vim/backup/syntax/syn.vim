" Vim syntax file
" Language:    Router DB script
" Version:     1.0
" Maintainer:  thlu@synology.com
" Last Change: 2010.03.12 10:30

syntax clear

if version < 508
  command! -nargs=+ HiLink hi link <args>
else
  command! -nargs=+ HiLink hi def link <args>
endif

" comment
syn match  synComment     /^\s*#.*$/
HiLink	synComment	Comment

" section
syn region  synSection start=/^\[[^\]]\+\]$/ end=/^#end$/ contains=@synSectionLine,synSectionKeys,synComment nextgroup=synSection keepend skipempty
syn match   synSectionKeys /^\[\(login\|logout\|PF add port\|PF add range\|PF delete port\|PF delete range\)\]/ contained
HiLink	synSectionKeys	Statement

syn cluster synSectionLine contains=synUrl,synModule,synControl
syn match   synUrl	/^[^\[#].*$/ contains=scriptVar,synCustomVar,urlParams contained
syn match   synModule	/^\${syno_\(custom\|macro\)_[^}]\+}$/ contains=synCustom,synMacro contained
syn match   synControl  /^syno_\(sleep\|if_greater_than\).*$/ contains=synoFunc contained
HiLink  synModule	Macro

syn keyword synoFunc	syno_if_greater_than syno_sleep contained nextgroup=synoFuncParam
syn match   synoFuncParam /([^)]*)/ contained contains=synConstant
syn match   synConstant	/[^,=()]*/ contained contains=synCustomVar,scriptVar
HiLink  synConstant	Constant
HiLink	synoFunc	Identifier

syn match   urlParams	/?.*$/ contained contains=urlAssign
syn match   urlAssign	/\([?&]\@<=[^=?&]\+=[^=?&@]*\|@.\+$\)/ contained contains=urlVar
syn match   urlVar	/[^=&@?]*/ contained contains=scriptVar,synCustomVar nextgroup=urlVarDelim
syn match   urlVarDelim	/=/ contained transparent nextgroup=urlVarValue
syn match   urlVarValue	/[^=&@?]*/ contained contains=scriptVar,synCustomVar
HiLink	urlVar		Identifier
HiLink	urlVarValue	Constant

" default variable
syn match   scriptVar	/\${[^}]\+}/ contains=scriptVarKey contained
syn keyword scriptVarKey user pass http router_port router_ip rule_id comment src_ip src_ip1 src_ip2 src_ip3 src_ip4 sport_start sport_end sport sport_num rport_start rport_end rport_num rport proto contained
HiLink	scriptVar	Macro
HiLink  scriptVarKey	Type

" custom variable define
syn match  synCustom	/^\${syno_custom_[^}]\+}=.*$/ contains=desCustomKey,desModules,scriptVar contained
syn match  synCustomKey	/\${syno_custom_[^}]\+}/ contained
HiLink	synCustomKey	Macro

" custom macro define
syn match  synMacro	/^\${syno_macro_[^}]\+}=.*/ contains=desMacroKey,desModules,scriptVar contained
syn match  synMacroKey	/\${syno_macro_[^}]\+}/ contained
HiLink	synMacroKey	Macro

syn match synCustomVar	/\${syno_\(custom\|macro\)_[^}]\+}/ contained
HiLink	synCustomVar	Macro

delcommand HiLink
