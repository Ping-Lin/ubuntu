nmap <buffer>gd	:let @z = @"<CR>l?commit<CR>w"xyw:let @" = @z<CR>:tabe<CR>:0r !git show <C-r>x -- .<CR>:setlocal buftype=nofile readonly modifiable<CR>gg:set ft=diff<CR><CR>
nmap <buffer>gc :let @z = @"<CR>l?commit<CR>w"xyw:let @" = @z<CR>:tabe<CR>:0r !git diff <C-r>x -- .<CR>:setlocal buftype=nofile readonly modifiable<CR>gg:set ft=diff<CR><CR>

nmap <buffer>gD	:let @z = @"<CR>l?commit<CR>w"xyw:let @" = @z<CR>:tabe<CR>:0r !git show <C-r>x<CR>:setlocal buftype=nofile readonly modifiable<CR>gg:set ft=diff<CR><CR>
nmap <buffer>gC :let @z = @"<CR>l?commit<CR>w"xyw:let @" = @z<CR>:tabe<CR>:0r !git diff <C-r>x<CR>:setlocal buftype=nofile readonly modifiable<CR>gg:set ft=diff<CR><CR>
