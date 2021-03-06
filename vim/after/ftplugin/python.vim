" Enable folding
if exists("b:loaded_SimpylFold")
  setl foldmethod=expr
else
  setl foldmethod=indent
endif
setl foldlevel=99

" Add the proper PEP8 indentation standard
setl tabstop=4
setl softtabstop=4
setl shiftwidth=4
setl textwidth=79
setl expandtab
setl autoindent
setl fileformat=unix
setl colorcolumn=73,+1

" Set compiler
compiler python

" Compiling shortcut
command! -nargs=0 Compile up | let g:_tem_makeprg = &makeprg |
  \ let g:_tem_fpath = expand("%:p:S") | let g:_tem_fname = expand("%:t") |
  \ vert new | cal termopen(g:_tem_makeprg . " " . g:_tem_fpath .
  \ " 2>&1 | tee /tmp/" . g:_tem_fname . ".err") |
  \ unl g:_tem_makeprg g:_tem_fpath g:_tem_fname | norm i
command! -nargs=0 Readcfile cfile /tmp/%:t.err
command! -nargs=0 Opencfile e /tmp/%:t.err
nnoremap <buffer> <F11> :Compile<CR>
nnoremap <buffer> <F10> :Readcfile<CR>
nnoremap <buffer> <F9> :Opencfile<CR>

" options for python syntax highlighting
let python_highlight_all = 1

" for Plugin tmhedberg/SimpylFold

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= "| setl fdm< fdl< cink< indk< inc< inex< sua< com< cms< ofu< et< sw< sts< ts< kp< | delc Compile| delc Readcfile| delc Opencfile"
else
  let b:undo_ftplugin = "setl fdm< fdl< cink< indk< inc< inex< sua< com< cms< ofu< et< sw< sts< ts< kp<| delc Compile| delc Readcfile| delc Opencfile"
endif
