setl shiftwidth=2
setl softtabstop=2
setl formatoptions=cqjl

let b:_undo_ftplugin = 'setl sw< sts< fo<'
if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '| ' . b:_undo_ftplugin
else
  let b:undo_ftplugin = b:_undo_ftplugin
endif
