setl textwidth=72
setl wrap
setl linebreak
setl spell
setl spelllang=en_gb
setl spellfile=~/.vim/spell/en.utf-8.add
setl colorcolumn=51,+1

let b:_undo_ftplugin = "setl tw< wrap< lbr< spell< spl< spf< cc<"
if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '| ' . b:_undo_ftplugin
else
  let b:undo_ftplugin = b:_undo_ftplugin
endif
