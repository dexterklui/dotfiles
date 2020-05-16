" DQToggleConceal:  Plugin for toggling conceallevel
" Maintainer:	    DQ
" Lat Change:	    30 Apr 2020
" Version:	    1.2

" Abort if running in vi-compatible mode or the user doesn't want us.
  if &cp || exists('g:loaded_DQToggleConceal')
    if &cp && &verbose
      echo "Not loading DQToggleConceal in compatible mode."
    elseif exists('g:loaded_DQToggleConceal')
      echo "DQToggleConceal was loaded already."
    endif
    finish
  endif

" vimscript thingy
  let s:save_cpo = &cpo
  set cpo&vim

" Defining functions
  function DQCancelConceal()
    if &cole != 0
      let w:DQConcealLevel = &cole
      let &cole = 0
      echo "Conceal level has been changed to 0 (NO concealment)."
    endif
  endfunction

  function DQConceal()
    if exists('w:DQConcealLevel')
      let &cole = w:DQConcealLevel
      echo "Conceal level has been changed to " . w:DQConcealLevel . "."
      unlet w:DQConcealLevel
    elseif exists('g:DQToggleConcealLevel') ? g:DQToggleConcealLevel =~ '0\|1\|2\|3' : 0
      let &cole = g:DQToggleConcealLevel
      echo "Conceal level has been changed to " . g:DQToggleConcealLevel . "."
    else
      let &cole = 2
      echo "Conceal level has been changed to 2."
    endif
  endfunction

  function DQToggleConceal()
    if &cole != 0
      call DQCancelConceal()
    else
      call DQConceal()
    endif
  endfunction

  function DQToggleNormalCocu()
    if &cocu =~ '.*n.*'
      set cocu-=n
      echo "Normal mode WILL reveal concealment."
    else
      set cocu+=n
      echo "Normal mode will NOT reveal concealment."
    endif
  endfunction

" Defining commands

" mappings
  noremap <leader>cl :call DQToggleConceal()<CR>
  noremap <leader>cn :call DQToggleNormalCocu()<CR>
  noremap <unique> <leader>cc :call DQToggleNormalCocu()<CR>

" vimscript thingy
  let &cpo = s:save_cpo
  unlet s:save_cpo
  let g:loaded_DQToggleConceal = 1

" vim:set sw=2 sts=2 fdm=indent:
