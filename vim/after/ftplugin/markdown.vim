setl expandtab
setl tabstop=4
setl shiftwidth=4
setl softtabstop=4
setl textwidth=80
setl colorcolumn=+1

let b:_undo_ftplugin = 'setl et< sw< sts< tw< cc<'
if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = b:_undo_ftplugin
else
  let b:undo_ftplugin .= '| ' . b:_undo_ftplugin
endif
