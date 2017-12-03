nmap <buffer><C-]>	"xyi[:ta <C-R>=DokuTag()<CR><CR>
function! DokuTag()
	let temp = @0
	let key = tolower(@x)
	let key = split(key, "|")[0]
	if key =~ "^\[" && key =~ "\]$"
		let key = strpart(key, 1, strlen(key)-2)
	endif
	if key =~ "^#"
		let key = substitute(expand("%"), ".".expand("%:e"), "", "") . key
	endif
	let key = substitute(key, " ", "_", "g")
	let key = substitute(key, '"', '\\\"',"g")
	let key = substitute(key, '\*', '\\\*',"g")
	let key = substitute(key, '\[', '\\\[',"g")
	let key = substitute(key, '\]', '\\\]',"g")
	let key = substitute(key, '\/', '\\\/',"g")
	let @0 = temp
	let @x = temp
	let @y = key
	return key
endfunction

"nmap <buffer><C-l>	:vsp /tmp/vim.<C-R>=expand("%:t")<CR>~<CR>ggdG:0r !~/.vim/tools/note_index.pl #<CR>:set ft=note<CR>:w<CR>
nmap <buffer><C-L>	:NoteIndexFile %<CR>


if !exists('g:note_command_edit')
    let g:note_command_edit = 'new'
endif
if !exists('g:note_bufhidden')
    let g:note_bufhidden = ''
endif

function! NoteIndexFile(file)
    let file = expand(a:file)
    let note_output = system('~/.vim/tools/note_index.pl --qf ' . file)
    if !strlen(note_output)
        echo "No output from git command"
        return
    endif

    " set open command to vnew
    let note_command_edit_save = g:note_command_edit
    let g:note_command_edit = 'leftabove vnew'
    call <SID>OpenNoteBuffer(note_output)
    let g:note_command_edit = note_command_edit_save

    exe 'vertical resize 30'
    setlocal nowrap
    setlocal filetype=jsqf
endfunction

function! s:OpenNoteBuffer(content)
    if exists('b:is_note_msg_buffer') && b:is_note_msg_buffer
        enew!
    else
        execute g:note_command_edit
    endif

    setlocal buftype=nofile readonly modifiable
    execute 'setlocal bufhidden=' . g:note_bufhidden

    silent put=a:content
    keepjumps 0d
    setlocal nomodifiable

    let b:is_note_msg_buffer = 1
endfunction

command! -nargs=1 NoteIndexFile          call NoteIndexFile(<q-args>)
