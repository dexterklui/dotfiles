"setl conceallevel=0
"
"if exists(b:undo_ftplugin)
"    if match(b:undo_ftplugin,'\%(cole\|concealevel)<') == -1
"	let b:undo_ftplugin .= "| setl cole<"
"    endif
"else
"    let b:undo_ftplugin = 'setl cole<'
"endif
