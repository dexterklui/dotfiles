" DQFoldText:       Plugin for generating fold text
" Maintainer:       Dexter K. Lui <dexterklui@pm.me>
" Last Change:      17 May 2020
" Version:          1.4

" Abort if running in vi-compatible mode or the user doesn't want us.
  if &cp || exists('g:loaded_DQFoldText')
    if &cp && &verbose
      echo "Not loading DQFoldText in compatible mode."
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
  let l:line = substitute(l:line, '/\*\|\*/\|{\{3}\d\=', '', 'ge')

  " If no emoji supports TODO
  if $TERM ==# 'linux'
    if exists('g:loaded_gitgutter') && gitgutter#fold#is_changed()
      return '+' . v:folddashes . l:line . '(*) [' . l:nrline . 'L]'
    else
      return '+' . v:folddashes . l:line . '[' . l:nrline . 'L]'
    endif

  " If there is emoji supports
  else " $TERM !=# 'linux'

    " if there is modified lines unstaged (Git)
    if exists('g:loaded_gitgutter') && gitgutter#fold#is_changed()
      if l:foldlevel == 1
        return '🔺' . l:line . '📝 [' . l:nrline . 'L]'
      elseif l:foldlevel == 2
        return ' 🔸' . l:line . '📝 [' . l:nrline . 'L]'
      elseif l:foldlevel == 3
        return '  🔹' . l:line . '📝 [' . l:nrline . 'L]'
      elseif l:foldlevel == 4
        if &bg ==# 'dark'
          return '   ▫️ ' . l:line . '📝 [' . l:nrline . 'L]'
        else
          return '   ▪️ ' . l:line . '📝 [' . l:nrline . 'L]'
        endif " background: dark, light
      else
        if &bg ==# 'dark'
          return '   ▫️ ' . repeat('▫️ ', l:foldlevel-4) . l:line . '📝 [' . l:nrline . 'L]'
        else
          return '   ▪️ ' . repeat('▪️ ', l:foldlevel-4) . l:line . '📝 [' . l:nrline . 'L]'
        endif " background: dark, light
      endif " foldlevel: 1, 2, 3, 4, >4

    " if there is no modified lines unstaged (Gitgutter)
    else
      if l:foldlevel == 1
        return '🔺' . l:line . '[' . l:nrline . 'L]'
      elseif l:foldlevel == 2
        return ' 🔸' . l:line . '[' . l:nrline . 'L]'
      elseif l:foldlevel == 3
        return '  🔹' . l:line . '[' . l:nrline . 'L]'
      elseif l:foldlevel == 4
        if &bg ==# 'dark'
          return '   ▫️ ' . l:line . '[' . l:nrline . 'L]'
        else
          return '   ▪️ ' . l:line . '[' . l:nrline . 'L]'
        endif " background: dark, light
      else
        if &bg ==# 'dark'
          return '   ▫️ ' . repeat('▫️ ', l:foldlevel-4) . l:line . '[' . l:nrline . 'L]'
        else
          return '   ▪️ ' . repeat('▪️ ', l:foldlevel-4) . l:line . '[' . l:nrline . 'L]'
        endif " background: dark, light
      endif " foldlevel: 1, 2, 3, 4, >4
    endif " Git's unstage modified lines: True, False
  endif " Support emoji: False, True
  " Reserved emojis: 🍳🥒🥢♂️ 🔗📎🔧💡📌📍➿🔅🔺🔸🔹▫️ ▪️ 📝
endfunction

" Setting
  set foldtext=DQFoldText()

" vimscript thingy
  let &cpo = s:save_cpo
  unlet s:save_cpo
  let g:loaded_DQFoldText = 1

" vim:set sw=2 sts=2 fdm=indent:
