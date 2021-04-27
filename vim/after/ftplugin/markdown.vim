setl expandtab
setl tabstop=4
setl shiftwidth=4
setl textwidth=80

let b:_undo_ftplugin = 'setl et< ts< sw<< tw<'
if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '| ' . b:_undo_ftplugin
else
  let b:undo_ftplugin = b:_undo_ftplugin
endif
