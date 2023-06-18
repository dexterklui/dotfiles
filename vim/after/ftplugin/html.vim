" Enable folding
setl fdm=indent
setl foldlevel=99

setl tabstop=2
setl shiftwidth=2

setl formatoptions-=t

let b:_undo_ftplugin = 'setl fdm< fdl< ts< sw< fo<'
if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '| ' . b:_undo_ftplugin
else
  let b:undo_ftplugin = b:_undo_ftplugin
endif
