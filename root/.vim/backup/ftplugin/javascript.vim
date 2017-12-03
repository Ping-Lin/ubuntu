if exists("current_compiler")
  finish
endif
let current_compiler = "jshint"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

if !exists("g:javascript_linter")
	let g:javascript_linter = "jslint"
endif

if g:javascript_linter == "jshint"
	CompilerSet makeprg=jshint\ %
	CompilerSet errorformat=%f:\ line\ %l\\,\ col\ %c\\,\ %m
elseif g:javascript_linter == "jslint"
	CompilerSet makeprg=jslint\ --terse\ %
endif

nmap <buffer><F9>  :make<CR>
"nmap <buffer><F9>  :cex system("jslint --terse <C-R>=expand("%")<CR>")<CR>
nmap <buffer><C-l> :20vsp /tmp/vim.%:t~<CR>ggdG:0r !~/.vim/tools/jsqf.pl #<CR>:w<CR>:set ft=jsqf<CR>:set nowrap<CR>gg
