setl expandtab
setl shiftwidth=2
setl tabstop=2

func <SID>CompileJava()
  let l:compiler = "javac"
  let l:flags = ""

  let l:src = expand("%:.")
  let l:bytecode = expand("%:.:t:r") . ".class"
  let l:errfile = expand("%:.:t:r") . ".err"

  if (system("ls | grep -i '^makefile$'") !=# "")
    let l:cmd = "make " . l:prg
  else
    let l:cmd = '!' . l:compiler . ' ' . l:flags . ' ' . l:src
    let l:cmd .= ' 2>&1 | tee ' . l:errfile
  endif

  update
  exe l:cmd
  if filereadable(l:errfile)
    exe 'cfile ' . l:errfile
    if !empty(getqflist())
      crewind
    else
      cclose
    endif
  endif
  exe 'silent !rm -f ' . l:errfile
endf

" Shortcuts for compilation
nnoremap <buffer> <F11> :call <SID>CompileJava()<CR>
nnoremap <buffer> <F12> :vsp term://java %:.:r<CR>

let b:_undo_ftplugin = 'setl et< sw< ts<'
if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '| ' . b:_undo_ftplugin
else
  let b:undo_ftplugin = b:_undo_ftplugin
endif
