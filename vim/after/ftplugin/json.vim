setl tabstop=2
setl shiftwidth=2

let b:_undo_ftplugin = 'setl ts< sw<'
if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '| ' . b:_undo_ftplugin
else
  let b:undo_ftplugin = b:_undo_ftplugin
endif
