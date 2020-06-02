" DQNote:           Vim plugin for DQNote files (.dqn)
" Maintainer:       Dexter K. Lui <dexterklui@pm.me>
" Latest Change:    6 May 2020
" Version:          1.34.3 (DQN v1.34)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vimscript thingy {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Abort if running in vi-compatible mode or the user doesn't want us. {{{2
""""""""""""""""""""""""""""""""""""""""
if &cp || exists('g:loaded_DQNote')
  if &cp && &verbose
    echo "Not loading DQNote in compatible mode."
  endif
  finish
endif

" vimscript thingy {{{2
""""""""""""""""""""""""""""""""""""""""
let s:save_cpo = &cpo
set cpo&vim

" Defining functions {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Functions for updating DQNote version {{{2
""""""""""""""""""""""""""""""""""""""""
function DQNVersion()
" Check version of DQN file{{{
"
" Return the version (float) if it is a DQN file and has a valid stamp.
" Return 0 if it is a DQN file but does not have a valid stamp.
" Return -1 if it is NOT a DQN file
  if expand('%:e') !~ '^dqn$'
    return -1
  elseif getline(1) !~ '^/// Language: DQNote[-_][0-9.]\+'
    return 0
  else
    return str2float(substitute(getline(1), '^/// Language: DQNote[-_]', '', ''))
  endif
endfunction
"}}}
function DQNUpdate() abort
" Update dqn file{{{
  " Only run this script when it is a dqn file.
  if DQNVersion() == -1
    echoe 'This is not a DQNote! No update is done.'
    return
  elseif DQNVersion() >= 1.34
    echom 'This DQNote is already at version 1.34 or newer, no update is done.'
    return
  endif

  " first creat an empty quick fix list for later vimgrepadd cmd
  call setqflist([])

  " Update DQN file based on its current version according in a sequence.
  if DQNVersion() < 1.32
    call dqnupdate#v1_32()
  endif
  if DQNVersion() < 1.33
    call dqnupdate#v1_33()
  endif
  if DQNVersion() < 1.34
    call dqnupdate#v1_34()
  endif

  " Save changes
  update
  echom 'This DQNote has been updated to v1.34!'

  " Open quickfix list if there is any item got by vimgrepadd cmd
  if getqflist() != []
    clist
    echoe 'Here are some areas where you may want to make manual update.'
  endif
endfunction
"}}}
" Functions for handling Titles {{{2
""""""""""""""""""""""""""""""""""""""""
function s:titlelv(line)
" Return the title level of current line{{{
  let l:string = getline(a:line)
  if l:string =~ '^\[\~{ .* }\~]\%( \={\{3}1\)\=$'
    return 1
  elseif l:string =~ '^ == .* ==\%( \={\{3}2\)\=$'
    return 2
  elseif l:string =~ '^  > \S.* <\%( \={\{3}3\)\=$'
    return 3
  elseif l:string =~ '^ \{3}|.*|\%( \={\{3}4\)\=$'
    return 4
  else
    return 0
  endif
endfunction
"}}}
function s:titleContent(line)
" Return a string of the content of current line without title markers{{{
  let l:titlelevel = s:titlelv(a:line)
  if l:titlelevel == 1
    let l:content = substitute(getline(a:line), '^\[\~{ ', '', '')
    return substitute(l:content, ' }\~]\%( \={\{3}1\)\=$', '', '')
  elseif l:titlelevel == 2
    let l:content = substitute(getline(a:line), '^ == ', '', '')
    return substitute(l:content, ' ==\%( \={\{3}2\)\=$', '', '')
  elseif l:titlelevel == 3
    let l:content = substitute(getline(a:line), '^  > ', '', '')
    return substitute(l:content, ' <\%( \={\{3}3\)\=$', '', '')
  elseif l:titlelevel == 4
    let l:content = substitute(getline(a:line), '^ \{3}|', '', '')
    return substitute(l:content, '|\%( \={\{3}4\)\=$', '', '')
  else
    let l:content = substitute(getline(a:line), '^\s*', '', '')
    return substitute(l:content, '\s*\%({\{3}\d*\)\=$', '', '')
  end
endfunction
"}}}
function s:hasFoldMk(line)
" Check if there is fold marker at the end of the current line{{{
" Return 1 if yes, 0 if no.
  if getline(a:line) =~ ' \={\{3}\d*$'
    return 1
  else
    return 0
  endif
endfunction
"}}}
function DQNTitleLevelUp() range
" Make current line accend by 1 title level{{{
  if DQNVersion() == -1
    echom 'This is not a DQN file! Abort function.'
    return
  endif
  if a:firstline == a:lastline
    let l:is_oneline = 1
  endif
  for l:line in range(a:firstline, a:lastline)
    let l:titlelevel = s:titlelv(l:line)
    if l:titlelevel == 1 && exists('l:is_oneline')
      echo 'This line is already at the top level!'
    elseif l:titlelevel == 2
      if s:hasFoldMk(l:line)
        call setline(l:line, '[~{ ' . s:titleContent(l:line) . ' }~] {'.'{{1')
      else
        call setline(l:line, '[~{ ' . s:titleContent(l:line) . ' }~]')
      endif
    elseif l:titlelevel == 3
      if s:hasFoldMk(l:line)
        call setline(l:line, ' == ' . s:titleContent(l:line) . ' == {'.'{{2')
      else
        call setline(l:line, ' == ' . s:titleContent(l:line) . ' ==')
      endif
    elseif l:titlelevel == 4
      call setline(l:line, '  > ' . s:titleContent(l:line) . ' < {'.'{{3')
    elseif !l:titlelevel && exists('l:is_oneline')
    " Ignore lines that were not DQN Titles when processing a visual range of line
      if s:hasFoldMk(l:line)
        call setline(l:line, '   |' . s:titleContent(l:line) . '| {'.'{{4')
      else
        call setline(l:line, '   |' . s:titleContent(l:line) . '|')
      endif
    endif
  endfor
endfunction
"}}}
function DQNTitleLevelDown() range
" Make current line decend by 1 title level{{{
  if DQNVersion() == -1
    echom 'This is not a DQN file! Abort function.'
    return
  endif
  if a:firstline == a:lastline
    let l:is_oneline = 1
  endif
  for l:line in range(a:firstline, a:lastline)
    let l:titlelevel = s:titlelv(l:line)
    if l:titlelevel == 1
      if s:hasFoldMk(l:line)
        call setline(l:line, ' == ' . s:titleContent(l:line) . ' == {'.'{{2')
      else
        call setline(l:line, ' == ' . s:titleContent(l:line) . ' ==')
      endif
    elseif l:titlelevel == 2
      if s:hasFoldMk(l:line)
        call setline(l:line, '  > ' . s:titleContent(l:line) . ' < {'.'{{3')
      else
        call setline(l:line, '  > ' . s:titleContent(l:line) . ' <')
      endif
    elseif l:titlelevel == 3
      call setline(l:line, '   |' . s:titleContent(l:line) . '|')
    elseif l:titlelevel == 4
      call setline(l:line, "    " . s:titleContent(l:line))
    elseif !l:titlelevel && exists('l:is_oneline')
      echo 'This line is already at lower than level 4!'
    endif
  endfor
endfunction
"}}}
function DQNTitleFoldMarkerToggle() range
" Add/remove fold markers at the end of line according to title lvl{{{
  if DQNVersion() == -1
    echom 'This is not a DQN file! Abort function.'
    return
  endif
  if a:firstline == a:lastline
    let l:is_oneline = 1
  endif
  for l:line in range(a:firstline, a:lastline)
    let l:titlelevel = s:titlelv(l:line)
    if s:hasFoldMk(l:line)
      call setline(l:line, substitute(getline(l:line), '\s*{'.'{{\d*$', '', ''))
    elseif !l:titlelevel && exists('l:is_oneline')
      call setline(l:line, getline(l:line) . ' {'.'{{')
    else
      call setline(l:line, getline(l:line) . ' {'.'{{' . l:titlelevel)
    endif
  endfor
endfunction
"}}}
" Functions for handling vim's formatoptions {{{2
""""""""""""""""""""""""""""""""""""""""
function FoToggle()
" Turning on/off vim's formatoptions{{{
  if &fo =~ '^$' && exists('b:dq_fo')
    let &fo = b:dq_fo
    unlet b:dq_fo
    echo 'Restored to previous formatoptions (auto newline).'
  elseif &fo =~ '^$'
    set fo&
    echo "Restored formatoptions to Vim's default."
  else
    let b:dq_fo = &fo
    set fo=
    echo 'Cleared formatoptions. (No auto newline)'
  endif
endfunction
"}}}
" Defining commands and mappings {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Defining commands {{{2
""""""""""""""""""""""""""""""""""""""""
command -range DQNUpTitle <line1>,<line2>call DQNTitleLevelUp()
command -range DQNDownTitle <line1>,<line2>call DQNTitleLevelDown()
command -range DQNFoldMarkerToggle <line1>,<line2>call DQNTitleFoldMarkerToggle()
command DQNUpdate call DQNUpdate()

" Defining mappings {{{2
""""""""""""""""""""""""""""""""""""""""
" mappings
nnoremap <Leader>fo :call FoToggle()<CR>

" vimscript thingy {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let &cpo = s:save_cpo
unlet s:save_cpo
let g:loaded_DQNote = 1

" vim:set sw=2 sts=2 fdm=marker:
