setl shiftwidth=2
setl tabstop=2
setl textwidth=0
setl makeprg=pdflatex\ %
setl smartcase

let b:_undo_ftplugin = 'setl sw< ts< tw< mp< scs<'
if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '| ' . b:_undo_ftplugin
else
  let b:undo_ftplugin = b:_undo_ftplugin
endif
