setl expandtab
setl shiftwidth=2
setl softtabstop=2

if !exists(b:undo_ftplugin)
  let b:undo_ftplugin = 'setl et< sw< sts<'
else
  let b:undo_ftplugin .= '| ' . 'setl et< sw< sts<'
endif
