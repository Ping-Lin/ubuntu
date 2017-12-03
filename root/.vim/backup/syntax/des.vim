" Vim syntax file
" Language:    Router DB description
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
syn match  desComment     /^\s*#.*$/
HiLink	desComment	Comment

" assign delimiter
syn match  desDelim       /=/ contained

syn region  desSection start=/^\[[^\]]\+\]$/ end=/^\(#end\|$\)/ contains=@desSectionLine,desSectionKeys nextgroup=desSection keepend transparent
syn region  desGlobal  start=/^\[global\]$/ end=/^\(#end\|$\)/ contains=@desGlobalLine,desSectionKeys nextgroup=desSection keepend transparent

syn match  desSectionKeys /^\[\(global\|PF port page\|PF range page\)\]/ contained
HiLink	desSectionKeys	Statement

"syn match  desGlobalStart /\[global\]/ contains=desSessionKeys nextgroup=@desGlobalLine,desSectionStart skipnl

" inner [global]
syn cluster desGlobalLine contains=desGlobalYN,desGlobalInt,desGlobalstr,desCustom,desMacro,desComment
syn match  desGlobalKey	/post login\|post logout\|cgi wait time\|syntax version\|default user\|default pass/ nextgroup=desDelim contained
syn match  desGlobalYN	/^\(post login\|post logout\)\>.*$/ contains=desGlobalKey,desDelim,desYN,desError contained
syn match  desGlobalInt	/^\(cgi wait time\|syntax version\)\>.*$/ contains=desGlobalKey,desDelim,desInt,desError contained
syn match  desGlobalstr	/^\(default user\|default pass\)\>.*$/ contains=desGlobalKey,desDelim,desStr contained
HiLink	desGlobalKey	Type

" inner [{section}]
syn cluster desSectionLine contains=desSecStr,desSecYN,desSecInt,desSecOA,desSecSM,desCustom,desMacro,desComment
syn match  desSecKey	/max rule\|rule id start\|change router port\|submit post\|support mix port and range\|add type\|delete type\|support port\|support range\|token delimiter\|range delimiter\|tcp_udp\|tcp\|udp/ nextgroup=desDelim contained
syn match  desSecInt	/^\(max rule\|rule id start\)\>.*$/  contains=desSecKey,desDelim,desInt,desError contained
syn match  desSecYN	/^\(change router port\|submit post\|support mix port and range\)\>.*$/ contains=desSecKey,desDelim,desYN,desError contained
syn match  desSecOA	/\(add type\|delete type\)\>.*$/ contains=desSecKey,desDelim,desOA,desError contained
syn match  desSecSM	/\(support port\|support range\)\>.*$/ contains=desSecKey,desDelim,desSM,desError contained
syn match  desSecStr	/^\(token delimiter\|range delimiter\|tcp\|udp\|tcp_udp\)\>.*$/ contains=desSecKey,desDelim,desStr contained
HiLink	desSecKey	Type

" default variable
syn match   scriptVar	/\${[^}]\+}/ contains=scriptVarKey contained
syn keyword scriptVarKey user pass http router_port router_ip rule_id comment src_ip sport rport proto contained
HiLink	scriptVar	Macro
HiLink  scriptVarKey	Type

" custom variable define
syn match  desCustom	/^\${syno_custom_[^}]\+}=.*$/ contains=desCustomKey,desModules,scriptVar contained
syn match  desCustomKey	/\${syno_custom_[^}]\+}/ contained
HiLink	desCustomKey	Macro

" custom macro define
syn match  desMacro	/^\${syno_macro_[^}]\+}=.*/ contains=desMacroKey,desModules,scriptVar contained
syn match  desMacroKey	/\${syno_macro_[^}]\+}/ contained
HiLink	desMacroKey	Macro

" SDK modules
syn match  desModules	/\(syno_webpage_get\|syno_exec_and_get_output\|syno_exec_and_get_return\)/ contained nextgroup=desModulesParam
HiLink	desModules	Function
syn match   desModulesParam	/([^)]*)/ contained contains=desConstant
syn match   desConstant		/[^,()]*/ contained contains=synCustomVar,scriptVar
syn match   synCustomVar	/\${syno_\(custom\|macro\)_[^}]\+}/ contained
HiLink  desConstant	Constant
HiLink	synCustomVar	Macro


" gereral yes/no, number, string
syn match  desError	/[^=]*$/ contained
syn match  desOA	/\(one\|all\)$/ contained
syn match  desSM	/\(single\|multi\)$/ contained
syn match  desYN	/\(yes\|no\)$/ contained
syn match  desInt	/\d\+$/ contained
syn match  desStr	/[^=]*$/ contained
HiLink	desError	Error
HiLink	desYN		Constant
HiLink	desOA		Constant
HiLink	desSM		Constant
HiLink	desInt		Constant
HiLink	desStr		Constant

delcommand HiLink
