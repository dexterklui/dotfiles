" Enable folding
setl fdm=indent
setl foldlevel=99

setl tabstop=3
setl shiftwidth=3
setl colorcolumn=+1

setl formatoptions-=t

" Set compiler
"compiler python

" for Plugin tmhedberg/SimpylFold

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= "| setl fdm< fdl< ts< sts< sw< cc< fo<"
else
  let b:undo_ftplugin = "setl fdm< fdl< ts< sts< sw< cc< fo<"
endif
