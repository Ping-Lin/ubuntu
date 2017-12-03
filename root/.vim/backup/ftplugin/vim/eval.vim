" vim:fdm=marker:
" Author:  Cornelius (林佑安)
" Email:   cornelius.howl@gmail.com

fun! EvalVimScriptRegion(s,e)
  let lines = getline(a:s,a:e)
  let file = tempname()
  cal writefile(lines,file)
  redir @e
  silent exec ':source '.file
  cal delete(file)
  redraw
  redir END
  echo "Region evaluated."

  if strlen(getreg('e')) > 0
    10new
    redraw
    silent file "EvalResult"
    setlocal noswapfile  buftype=nofile bufhidden=wipe
    setlocal nobuflisted nowrap cursorline nonumber fdc=0
    " syntax init
    set filetype="eval"
    syn match ErrorLine +^E\d\+:.*$+
    hi link ErrorLine Error
    silent $put =@e
  endif
endf

"2011.04.16 23:51 thlu: i dont know why this can not work
"augroup VimEval
"  au!
"  au filetype vim :command! -range Eval  :cal EvalVimScriptRegion(<line1>,<line2>)
"  au filetype vim :vnoremap <silent> e   :Eval<CR>
"augroup END
  
command! -range Eval  :cal EvalVimScriptRegion(<line1>,<line2>)
vnoremap <silent> e   :Eval<CR>

