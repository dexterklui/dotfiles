setl expandtab
setl tabstop=3
setl shiftwidth=3
setl textwidth=80
setl colorcolumn=+1

if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = 'setl et< sw< sts< tw< cc<'
else
  let b:undo_ftplugin .= '| ' . 'setl et< sw< sts< tw< cc<'
endif
