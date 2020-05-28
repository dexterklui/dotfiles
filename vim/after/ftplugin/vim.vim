setl shiftwidth=2
setl softtabstop=2

if !exists(b:undo_ftplugin)
  let b:undo_ftplugin = 'setl cole<'
else
  if match(b:undo_ftplugin,'\%(sw\|shiftwidth\)<') == -1
    let b:undo_ftplugin .= "| setl sw<"
  endif
  if match(b:undo_ftplugin,'\%(sts\|softtabstop\)<') == -1
    let b:undo_ftplugin .= "| setl sts<"
  endif
endif
