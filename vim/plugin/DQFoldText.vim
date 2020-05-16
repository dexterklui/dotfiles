" DQFoldText:	    Plugin for generating fold text
" Maintainer:	    DQ
" Lat Change:	    30 Apr 2020
" Version:	    1.3

" Abort if running in vi-compatible mode or the user doesn't want us.
  if &cp || exists('g:loaded_DQFoldText')
    if &cp && &verbose
      echo "Not loading DQFoldText in compatible mode."
    elseif exists('g:loaded_DQFoldText')
      echo "DQFoldText was loaded already."
    endif
    finish
  endif

" vimscript thingy
  let s:save_cpo = &cpo
  set cpo&vim

" Defining functions
function! DQFoldText()
  let l:nrline = v:foldend - v:foldstart + 1
  let l:foldlevel = foldlevel(v:foldstart)
  let l:line = substitute(getline(v:foldstart), '^\s*\|\s*$', '', 'ge')
  let l:line = substitute(l:line, '/\*\|\*/\|{{{\d\=', '', 'ge')
  if $TERM ==# 'linux'
    if exists('g:loaded_gitgutter') && gitgutter#fold#is_changed() == 1
      return '+' . v:folddashes . l:line . '(*) [' . l:nrline . 'L]'
    else
      return '+' . v:folddashes . l:line . '[' . l:nrline . 'L]'
    endif
  else
    if exists('g:loaded_gitgutter') && gitgutter#fold#is_changed() == 1
    " Icons:🍳🥒🥢♂️ 🔗📎🔧💡📌📍➿🔅🔺🔸🔹▫️ 📝
      if l:foldlevel == 1
	return '🔺' . l:line . '📝 [' . l:nrline . 'L]'
      elseif l:foldlevel == 2
	return ' 🔸' . l:line . '📝 [' . l:nrline . 'L]'
      elseif l:foldlevel == 3
	return '  🔹' . l:line . '📝 [' . l:nrline . 'L]'
      elseif l:foldlevel == 4
	return '   ▫️ ' . l:line . '📝 [' . l:nrline . 'L]'
      else
	return repeat(' ', l:foldlevel-1) . '▫️ ' . l:line . '📝 [' . l:nrline . 'L]'
      endif
    else
      if l:foldlevel == 1
	return '🔺' . l:line . '[' . l:nrline . 'L]'
      elseif l:foldlevel == 2
	return ' 🔸' . l:line . '[' . l:nrline . 'L]'
      elseif l:foldlevel == 3
	return '  🔹' . l:line . '[' . l:nrline . 'L]'
      elseif l:foldlevel == 4
	return '   ▫️ ' . l:line . '[' . l:nrline . 'L]'
      else
	return repeat(' ', l:foldlevel-1) . '▫️ ' . l:line . '[' . l:nrline . 'L]'
      endif
  endif
endfunction

" Setting
  set foldtext=DQFoldText()

" vimscript thingy
  let &cpo = s:save_cpo
  unlet s:save_cpo
  let g:loaded_DQFoldText = 1

" vim:set sw=2 sts=2 fdm=indent:
