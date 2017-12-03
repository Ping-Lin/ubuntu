nmap <buffer><F9>  :cex system("cppcheck --template=gcc --enable=all \"<C-R>=expand("%")<CR>\"")<CR>
"set errorformat+=[%f:%l]:\ %m

"nmap <buffer><F9>  :make<CR>
