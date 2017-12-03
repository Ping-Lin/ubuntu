nmap <buffer><F9>	:MKD2HTML<CR>

nmap <buffer><C-l> :20vsp /tmp/vim.%:t~<CR>ggdG:0r !~/.vim/tools/mdqf.pl #<CR>:w<CR>:set ft=jsqf<CR>:set nowrap<CR>gg

setlocal et sta sw=4 sts=4
