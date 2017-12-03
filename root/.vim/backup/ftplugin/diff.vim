" mark this position
"
let g:diff_type = 'git'

nmap gd>	:tabe <C-r>=Find_diff_location()<CR><CR>
" for debugging:
"map gdx	:echo <C-r>=Find_diff_location()<CR>
function! Find_diff_location()
	let temp = @"
	let line = line(".")
	let name = './'

	" remember location
	normal mx

	" guess diff type
	normal gg
	if search("RCS file: /cvs", '')
		let g:diff_type = 'cvs'
	end
	normal `x

	if g:diff_type == 'git'
		" get git root
		let @x = system('git rev-parse --show-cdup')
		let @x = strpart(@x, 0, strlen(@x) -1)
		let name = @x
	end

	" get line number
	let @x = search('^@@ ', 'b') "TODO no search result
	normal 0f+l"yyt,

	" get - count
	let mc = 0
	let lnum = @x
	while lnum < line + 1
		if getline(lnum) =~ '^-'
			let mc = mc + 1
		end
		let lnum = lnum + 1
	endwhile
	
	" compute correct line number
	let line = @y + line - @x - mc

	" get file name
	let @x = search('^+++ ', 'b')
	if g:diff_type == 'git'
		normal 0f f/l"yy$
	elseif g:diff_type == 'cvs'
		normal 0W"yyW
	end
	let name = name . @y

	" return to original location
	normal `x
	let @" = temp
	return "+". line . " ". name
endfunction
