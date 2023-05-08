" DQFold:           Plugin for generating fold text
" Maintainer:       Dexter K. Lui <dexterklui@pm.me>
" Last Change:      17 May 2020
" Version:          1.5
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" To use the foldtext, add the line:
" set foldtext=DQFoldText()

" Abort if running in vi-compatible mode or the user doesn't want us. {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &cp || exists('g:loaded_DQFold')
  if &cp && &verbose
    echo "Not loading DQFold in compatible mode."
  endif
  finish
endif

" vimscript thingy
let s:save_cpo = &cpo
set cpo&vim

" Defining functions {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
func DQFoldText()
" create fold text {{{
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
      else
        return '   ' .repeat('▪ ', l:foldlevel-3) .l:line . '📝 [' . l:nrline . 'L]'
      "elseif l:foldlevel == 4
      "  if &bg ==# 'dark'
      "    return '   ▫️ ' . l:line . '📝 [' . l:nrline . 'L]'
      "  else
      "    return '   ▪️ ' . l:line . '📝 [' . l:nrline . 'L]'
      "  endif " background: dark, light
      "else
      "  if &bg ==# 'dark'
      "    return '   ▫️ ' . repeat('▫️ ', l:foldlevel-4) . l:line . '📝 [' . l:nrline . 'L]'
      "  else
      "    return '   ▪️ ' . repeat('▪️ ', l:foldlevel-4) . l:line . '📝 [' . l:nrline . 'L]'
      "  endif " background: dark, light
      endif " foldlevel: 1, 2, 3, 4, >4

    " if there is no modified lines unstaged (Gitgutter)
    else
      if l:foldlevel == 1
        return '🔺' . l:line . '[' . l:nrline . 'L]'
      elseif l:foldlevel == 2
        return ' 🔸' . l:line . '[' . l:nrline . 'L]'
      elseif l:foldlevel == 3
        return '  🔹' . l:line . '[' . l:nrline . 'L]'
      else
        return '   ' .repeat('▪ ', l:foldlevel-3) .l:line . '[' . l:nrline . 'L]'
      "elseif l:foldlevel == 4
      "  if &bg ==# 'dark'
      "    return '   ▫️ ' . l:line . '[' . l:nrline . 'L]'
      "  else
      "    return '   ▪️ ' . l:line . '[' . l:nrline . 'L]'
      "  endif " background: dark, light
      "else
      "  if &bg ==# 'dark'
      "    return '   ▫️ ' . repeat('▫️ ', l:foldlevel-4) . l:line . '[' . l:nrline . 'L]'
      "  else
      "    return '   ▪️ ' . repeat('▪️ ', l:foldlevel-4) . l:line . '[' . l:nrline . 'L]'
      "  endif " background: dark, light
      endif " foldlevel: 1, 2, 3, 4, >4
    endif " Git's unstage modified lines: True, False
  endif " Support emoji: False, True
  " Reserved emojis: 🍳🥒🥢♂️ 🔗📎🔧💡📌📍➿🔅🔺🔸🔹▫️ ▪️ 📝
endfunc " }}}

func s:CloFdChild()
" close all fold children of current fold {{{
  if foldclosed(line('.')) != -1
    let l:foldclosed = 1
  endif
  let l:line = line('.')
  let l:virtcol = virtcol('.')
  normal [z
  if foldlevel(line('.')) < foldlevel(l:line)
    exe "normal \<C-o>"
  endif
  exe "normal zoV]zo:foldclose!\rzv"
  call cursor(l:line,l:virtcol)
  if exists('l:foldclosed')
    normal zc
  endif
endfunc " }}}

func s:OpFdChild()
" open all fold children of current fold {{{
  let l:line = line('.')
  let l:virtcol = virtcol('.')
  normal [z
  if foldlevel(line('.')) < foldlevel(l:line)
    exe "normal \<C-o>"
  endif
  exe "normal zoV]zo:foldopen!\rzv"
  call cursor(l:line,l:virtcol)
endfunc " }}}

func s:Retab(old_indent, new_indent)
" This function doesn't deal with <Tab> characters, but indentation with spaces.
" It changes old space indentation amount into new space indentation amount. {{{
  if a:old_indent == a:new_indent
    return
  elseif a:old_indent < a:new_indent
    for l:i in range(10, 1, -1)
      let l:current_indent = a:old_indent * l:i
      let l:new_indent_string = repeat(" ", a:new_indent * l:i)
      silent exe "%s/^ \\{" . l:current_indent . "}\\ze\\S/"
            \. l:new_indent_string . "/e"
    endfor
  else
    for l:i in range(1, 10)
      let l:current_indent = a:old_indent * l:i
      let l:new_indent_string = repeat(" ", a:new_indent * l:i)
      silent exe "%s/^ \\{" . l:current_indent . "}\\ze\\S/"
            \. l:new_indent_string . "/e"
    endfor
  endif
endfunc " }}}

func s:SetIndent(new_indent)
" Set shift width and tab stop at the same time {{{
  exe "setl shiftwidth=" . a:new_indent
  exe "setl tabstop=" . a:new_indent
endfunc " }}}

func s:RetabAndSetShiftWidth(old_indent, new_indent)
" Call Retab then update shift width and tab stop option {{{
  call s:Retab(a:old_indent, a:new_indent)
  call s:SetIndent(a:new_indent)
endfunc " }}}

" Command {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command -nargs=* Retab call <SID>RetabAndSetShiftWidth(<f-args>)
command -nargs=1 Indent call <SID>SetIndent(<f-args>)

" Mappings {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap z[ :call <SID>CloFdChild()<CR>
nnoremap z{ zc:call <SID>CloFdChild()<CR>
nnoremap z] :call <SID>OpFdChild()<CR>

" vimscript thingy {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let &cpo = s:save_cpo
unlet s:save_cpo
let g:loaded_DQFold = 1

" vim:set sw=2 sts=2 fdm=marker:
