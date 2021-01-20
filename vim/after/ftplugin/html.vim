" Enable folding
setl foldlevel=99

setl tabstop=2
setl softtabstop=2
setl shiftwidth=2
setl colorcolumn=+1

" Set compiler
"compiler python

" for Plugin tmhedberg/SimpylFold

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= "| setl fdl< ts< sts< sw< cc<"
else
  let b:undo_ftplugin = "setl fdl< ts< sts< sw< cc<"
endif
