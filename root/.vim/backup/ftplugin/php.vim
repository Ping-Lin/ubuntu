
if exists("current_compiler")
  finish
endif
let current_compiler = "php"

setlocal makeprg=php\ %
setlocal errorformat=%*[%f:%l]\ $m

map <buffer><F9>	:make<CR>

