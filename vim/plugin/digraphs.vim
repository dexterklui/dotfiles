" dqdigraphs:    Define digraphs
" Maintainer:    Dexter K. Lui <dexterklui@pm.me>
" Latest Change: 10 Jan 2023
" Version:       b0.01
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vimscript thingy {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Abort if running in vi-compatible mode or the user doesn't want us. {{{2
""""""""""""""""""""""""""""""""""""""""
if &cp || exists('g:loaded_dqdigraphs')
  if &cp && &verbose
    echo "Not loading dqdigraphs in compatible mode."
  endif
  finish
endif

" vimscript thingy {{{2
""""""""""""""""""""""""""""""""""""""""
let s:save_cpo = &cpo
set cpo&vim

" Defining digraphs {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
digraphs \|- 8866 " ⊢ (turnstile)
digraphs \|= 8872 " ⊨ (double turnstile)
digraphs o+ 8853 " ⊕ (xor symbol)
digraphs (/ 8713 " ∉ (does not belong)

" vimscript thingy    {{{1
let &cpo = s:save_cpo
unlet s:save_cpo
let g:loaded_dqdigraphs = 1

" TODO Remove unwanted sections

" vim:set sw=2 sts=2 fdm=marker:
