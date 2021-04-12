setl expandtab
setl shiftwidth=2
setl softtabstop=2
setl textwidth=80
setl colorcolumn=+1

" Shortcuts for compilation
command! -nargs=0 Compile up | make %:t:r.out
nnoremap <buffer> <F11> :Compile<CR>
" The following are used with "comp" bash alias
command! -nargs=0 Readcfile cfile %:p:r.err
nnoremap <buffer> <F10> :Readcfile<CR>
command! -nargs=0 Opencfile view %:p:r.err
nnoremap <buffer> <F9> :Opencfile<CR>
command! -nargs=0 RunCppOut vsp term://./%:.:r.out
nnoremap <buffer> <F12> :RunCppOut<CR>

let b:_undo_ftplugin = 'setl et< sw< sts< tw< cc<'
if !exists(b:undo_ftplugin)
  let b:undo_ftplugin = b:_undo_ftplugin
else
  let b:undo_ftplugin .= '| ' . b:_undo_ftplugin
endif
let b:undo_ftplugin .= '| delc Compile| delc Readcfile| delc Opencfile| delc RunCppOut'
