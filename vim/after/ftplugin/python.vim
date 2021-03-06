" Enable folding
setl foldmethod=indent
setl foldlevel=99

" Add the proper PEP8 indentation standard
    setl tabstop=4
    setl softtabstop=4
    setl shiftwidth=4
    setl textwidth=79
    setl expandtab
    setl autoindent
    setl fileformat=unix

" Set compiler
compiler python

" options for python syntax highlighting
let python_highlight_all = 1

" for Plugin tmhedberg/SimpylFold

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= "| setl fdm< fdl< cink< indk< inc< inex< sua< com< cms< ofu< et< sw< sts< ts< kp<"
endif
