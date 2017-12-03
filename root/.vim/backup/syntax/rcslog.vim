" syntax
syntax match syno_branch		"^\s\+SDS.*-branch:"
syntax match syno_branch		"^\s\+DSM\d\+-\d\+-\d\+Q\d\+-branch:"
syntax match syno_tag			"^\s\+SDS.*-\d\{6\}:" contains=syno_version
syntax match syno_branch_tag		"^\s\+SDS.*-\d\+branch-.*:" contains=syno_version
syntax match syno_branch_tag		"^\s\+SDS.*-\d\+Q\d\+branch-.*:" contains=syno_version
syntax match syno_version		"\<\d\{4\}\>" contained

highlight syno_branch			ctermfg=6
highlight syno_branch_tag		ctermfg=5
highlight syno_version			ctermfg=2

syntax region syno_symnames	start="symbolic names:" end="keyword substitution:" fold contains=syno_branch,syno_tag,syno_branch_tag,syno_version
set foldmethod=syntax
set nofoldenable

" ftplugin
function! SynoRevision()
	let temp = @"
	normal m'$"xyiW
	if !search("^revision ".@x."$", "sw")
		echoh ErrorMsg
		echo "Revision not found!"
		echoh None
		normal `'
	endif
	let @" = temp
endfunction

nmap <buffer>	<C-]>	:call SynoRevision()<CR>
nmap <buffer>	gd	:let temp = @"<CR>mxgg/^Working file:<CR>$"zyiW`xl/^revision<CR>$"xyiWNN$"yyiW`x:let @" = temp<CR>:tabe<CR>:0r !cvs diff -bup -r <C-R>x -r <C-R>y <C-R>z<CR>:set ft=diff<CR>gg
