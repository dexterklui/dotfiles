setl expandtab
setl shiftwidth=3
setl tabstop=3

func <SID>CompileFortran()
  let l:compiler = "gfortran"
  let l:std = ""
  let l:error_flags = "-Wall -Wextra"

  let l:src = expand("%:.")
  let l:prg = expand("%:.:t:r") . ".out"
  let l:errfile = expand("%:.:t:r") . ".err"

  if (system("ls | grep -i '^makefile$'") !=# "")
    let l:cmd = "make " . l:prg
  else
    let l:cmd = '!' . l:compiler . ' ' . l:std . ' ' . l:error_flags
    let l:cmd .= ' -o ' . l:prg . ' ' . l:src
    let l:cmd .= ' 2>&1 | tee ' . l:errfile
  endif

  update
  exe l:cmd
  exe 'cfile ' . l:errfile
  exe 'silent !rm -f ' . l:errfile
  if !empty(getqflist())
    copen
    crewind
  else
    cclose
  endif
endf

" Shortcuts for compilation
nnoremap <buffer> <F11> :call <SID>CompileFortran()<CR>
nnoremap <buffer> <F12> :vsp term://./%:.:r.out<CR>

let b:_undo_ftplugin = 'setl et< sw< ts<'
if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '| ' . b:_undo_ftplugin
else
  let b:undo_ftplugin = b:_undo_ftplugin
endif
