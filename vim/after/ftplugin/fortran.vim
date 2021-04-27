setl expandtab
setl shiftwidth=3
setl tabstop=3

let b:_undo_ftplugin = 'setl et< sw< ts<'
if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '| ' . b:_undo_ftplugin
else
  let b:undo_ftplugin = b:_undo_ftplugin
endif
