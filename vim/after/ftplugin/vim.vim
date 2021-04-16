setl shiftwidth=2
setl softtabstop=2
setl formatoptions=cqjl

if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = 'setl sw< sts< fo<'
else
  let b:undo_ftplugin .= '| setl sw< sts< fo<'
endif
