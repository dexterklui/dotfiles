setl expandtab
setl shiftwidth=4
setl tabstop=4
setl textwidth=0

let b:_undo_ftplugin = 'setl et< sw< ts< tw<'
if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '| ' . b:_undo_ftplugin
else
  let b:undo_ftplugin = b:_undo_ftplugin
endif
