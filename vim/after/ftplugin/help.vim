nnoremap <buffer> <nowait> d }zz
nnoremap <buffer> <nowait> u {zz

let b:_undo_ftplugin = 'nun <buffer> <nowait> d| nun <buffer> <nowait> u'

if !exists('b:undo_ftplugin')
  let b:undo_ftplugin = b:_undo_ftplugin
else
  let b:undo_ftplugin .= '| ' . b:_undo_ftplugin
endif
