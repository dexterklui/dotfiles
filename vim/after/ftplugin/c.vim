setl expandtab
setl shiftwidth=4
setl tabstop=4
setl textwidth=80

func <SID>CompileC()
  let l:c = "gcc"
  let l:cpp = "g++"
  let l:cflag = "-std=c11"
  let l:cppflag = "-std=c++11"
  let l:warnflags = "-pedantic-errors -Wall -Wextra -Werror"

  let l:src = expand("%:.")
  let l:prg = expand("%:.:t:r") . ".out"
  let l:errfile = expand("%:.:t:r") . ".err"

  if (system("ls | grep -i '^makefile$'") !=# "")
    let l:cmd = "make " . l:prg
  elseif (expand("%:e") ==# 'c')
    let l:cmd = '!' . l:c . ' ' . l:cflag . ' ' . l:warnflags
    let l:cmd .= ' -o ' . l:prg . ' ' . l:src
    let l:cmd .= ' 2>&1 | tee ' . l:errfile
  else
    let l:cmd = '!' . l:cpp . ' ' . l:cppflag . ' ' . l:warnflags
    let l:cmd .= ' -o ' . l:prg . ' ' . l:src
    let l:cmd .= ' 2>&1 | tee ' . l:errfile
  endif

  update
  exe l:cmd
  if filereadable(l:errfile)
    exe 'cfile ' . l:errfile
  endif
  cwindow
  exe 'silent !rm -f ' . l:errfile
endf

" Shortcuts for compilation
nnoremap <buffer> <F11> :call <SID>CompileC()<CR>
nnoremap <buffer> <F12> :vsp term://./%:.:r.out<CR>

let b:_undo_ftplugin = 'setl et< sw< ts< tw<'
if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '| ' . b:_undo_ftplugin
else
  let b:undo_ftplugin = b:_undo_ftplugin
endif
