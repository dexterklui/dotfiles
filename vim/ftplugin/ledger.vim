" Ftplugin:      Filetype plugin for ledger
" Maintainer:    Dexter K. Lui <dexterklui@pm.me>
" Latest Change: 12 Jul 2020
" Version:       0.01
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

setl shiftwidth=2
setl foldmethod=syntax
setl textwidth=78
setl ignorecase
setl smartcase
setl tabstop=4

nnoremap <buffer> <F12> :silent<space>make<space><bar>redraw!<space><bar>cwindow<CR>
noremap <buffer> <F11> :LedgerStatus<CR>
inoremap <silent> <buffer> <C-B><Space> <C-r>=ledger#autocomplete_and_align()<CR>
vnoremap <silent> <buffer> <Tab> :LedgerAlign<CR>

command! -range LedgerClear <line1>,<line2>call ledger#transaction_state_set(line('.'), '*')
command! -range LedgerPending <line1>,<line2>call ledger#transaction_state_set(line('.'), '!')
command! -range LedgerEmpty <line1>,<line2>call ledger#transaction_state_set(line('.'), '')
command! -range LedgerDate <line1>,<line2>call ledger#transaction_date_set(line('.'), 'primary')
command! LedgerStatus call ledger#transaction_state_toggle(line('.'), ' *!')
