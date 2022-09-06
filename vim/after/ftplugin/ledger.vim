let g:ledger_extra_options = '--pedantic --explicit --check-payees'
let g:ledger_default_commodity = 'HK$'

setl shiftwidth=4
setl textwidth=0
setl smartcase
setl tabstop=8
setl makeprg=ledger

nnoremap <buffer> <F12> :silent<space>make<space><bar>redraw!<space><bar>cwindow<CR>
noremap <buffer> <F11> :LedgerStatus<CR>
inoremap <silent> <buffer> <M-;> <C-r>=ledger#autocomplete_and_align()<CR>
vnoremap <silent> <buffer> <Tab> :LedgerAlign<CR>
nnoremap <buffer> <M-w> :call ledger#transaction_post_state_toggle(line('.'), ' *!')<CR>
nnoremap <buffer> <M-d> :call ledger#transaction_date_set(line('.'), 'auxiliary')<CR>

command! -range LedgerClear <line1>,<line2>call ledger#transaction_state_set(line('.'), '*')
command! -range LedgerPending <line1>,<line2>call ledger#transaction_state_set(line('.'), '!')
command! -range LedgerEmpty <line1>,<line2>call ledger#transaction_state_set(line('.'), '')
command! -range LedgerDate <line1>,<line2>call ledger#transaction_date_set(line('.'), 'primary')
command! -range LedgerAuxDate <line1>,<line2>call ledger#transaction_date_set(line('.'), 'auxiliary')
command! LedgerStatus call ledger#transaction_state_toggle(line('.'), ' *!')

let b:_undo_ftplugin = 'setl sw< tw< scs< ts< makeprg<'
if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= '| ' . b:_undo_ftplugin
else
  let b:undo_ftplugin = b:_undo_ftplugin
endif
