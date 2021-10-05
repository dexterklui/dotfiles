setl expandtab
setl shiftwidth=2
setl tabstop=2

let s:default_java_tester_suffix = 'Tester'
let s:default_java_src_dir = 'src/'
let s:default_java_class_dir = 'bin/'

func <SID>CompileJava()
  let l:compiler = "javac"
  let l:flags = ""

  if exists('b:java_src_dir')
    let l:java_src_dir = b:java_src_dir
  elseif exists('g:java_src_dir')
    let l:java_src_dir = g:java_src_dir
  else
    let l:java_src_dir = s:default_java_src_dir
  endif

  if exists('b:java_class_dir')
    let l:java_class_dir = b:java_class_dir
  elseif exists('g:java_class_dir')
    let l:java_class_dir = g:java_class_dir
  else
    let l:java_class_dir = s:default_java_class_dir
  endif

  let l:src_path = expand("%:.")
  let l:bytecode_path = substitute(expand("%:.:r") . ".class",
        \ '^' . l:java_src_dir, l:java_class_dir, 'e')
  let l:errfile_path = expand("%:.:t:r") . ".err"

  if filereadable("Makefile") || filereadable("makefile")
    let l:cmd = "make " . l:bytecode_path
  else
    let l:cmd = '!' . l:compiler . ' ' . l:flags . ' ' . l:src_path
    let l:cmd .= ' 2>&1 | tee ' . l:errfile_path
  endif

  update
  exe l:cmd
  if filereadable(l:errfile_path)
    exe 'cfile ' . l:errfile_path
  endif
  cwindow
  exe 'silent !rm -f ' . l:errfile_path
endf

func! RunJava(arg = '')
  if exists('b:java_tester_suffix')
    let l:java_tester_suffix = b:java_tester_suffix
  elseif exists('g:java_tester_suffix')
    let l:java_tester_suffix = g:java_tester_suffix
  else
    let l:java_tester_suffix = s:default_java_tester_suffix
  endif

  if exists('b:java_src_dir')
    let l:java_src_dir = b:java_src_dir
  elseif exists('g:java_src_dir')
    let l:java_src_dir = g:java_src_dir
  else
    let l:java_src_dir = s:default_java_src_dir
  endif

  if exists('b:java_class_dir')
    let l:java_class_dir = b:java_class_dir
  elseif exists('g:java_class_dir')
    let l:java_class_dir = g:java_class_dir
  else
    let l:java_class_dir = s:default_java_class_dir
  endif

  echo l:java_class_dir
  let l:dir = substitute(expand("%:.:h") . '/',
        \ '^' . l:java_src_dir, l:java_class_dir, 'e')
  let l:dirflag = ''
  if l:dir !=# './'
    let l:dirflag = '-cp ' . l:dir
  endif

  let l:mainclass = expand("%:.:t:r")
  let l:testclass = ''
  if l:mainclass !~ l:java_tester_suffix . '$'
    let l:testclass = l:mainclass . l:java_tester_suffix
  endif

  if l:testclass !=# '' && filereadable(l:dir . l:testclass . '.class')
    let l:cmd = "vsp term://java " . l:dirflag . ' ' . l:testclass . ' ' . a:arg
  else
    let l:cmd = "vsp term://java " . l:dirflag . ' ' . l:mainclass . ' ' . a:arg
  endif
  exe l:cmd
endf

" Shortcuts for compilation
nnoremap <buffer> <F11> :call <SID>CompileJava()<CR>
nnoremap <buffer> <F12> :call RunJava()<CR>
" Commands
command -nargs=? RunJava call RunJava(<q-args>)

let b:_undo_ftplugin = 'setl et< sw< ts<'
if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '| ' . b:_undo_ftplugin
else
  let b:undo_ftplugin = b:_undo_ftplugin
endif
