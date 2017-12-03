" ===== cvs version =====
"nmap <buffer>gl	$"xyiW:tabe<CR>:0r !cvs log <C-r>x<CR><CR>gg:set ft=rcslog<CR>/^revision <CR>zzzM
"nmap <buffer>gd	$"xyiW:tabe<CR>:0r !cvs diff -bup <C-r>x<CR><CR>gg:set ft=diff<CR>gg
"vmap <buffer>gd :w! /tmp/cvsup.temp<CR>:tabe<CR>:0r !cvs diff -bup `grep -v "^\#" /tmp/cvsup.temp \| cut -f2 -d' '`<CR><CR>:set ft=diff<CR>gg
"vmap <buffer>gs :w! /tmp/cvsup.temp<CR>:tabe<CR>:0r !~/bin/diffset.pl /tmp/cvsup.temp<CR><CR>:set ft=diff<CR>gg

" ===== git version =====
let g:diff_opt = "-w"
nmap <buffer>gl	$"xyiW:tabe<CR>:0r !git log <C-r>x<CR><CR>gg:setlocal buftype=nofile readonly modifiable<CR>
nmap <buffer>gd	$"xyiW:tabe<CR>:0r !git diff <C-r>=g:diff_opt<CR> -- <C-r>x<CR><CR>gg:setlocal buftype=nofile readonly modifiable<CR>:set ft=diff<CR>gg
vmap <buffer>gd :w! /tmp/cvsup.temp<CR>:tabe<CR>:0r !git diff <C-r>=g:diff_opt<CR> -- `grep -v "^\#" /tmp/cvsup.temp \| cut -f2 -d'\t'`<CR><CR>:set ft=diff<CR>:setlocal buftype=nofile readonly modifiable<CR>gg
nmap <buffer>cd $b"xyi[:lcd <C-r>=system("~/bin/syno.bookmark ".@x)<CR><CR>
