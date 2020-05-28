" dqnupdate:      Updates DQNotes
" Maintainer:    Dexter K. Lui <dexterklui@pm.me>
" Latest Change: 26 May 2020
" Version:       1.34.0 (DQN v1.34)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This provides functions for function DQNUpdate() defined in plugin DQNote
" Function defined here are to update DQNotes.

function dqnupdate#v1_32()
  " Update dqn script to v1.32
  " "Upgrade to 1.2"
  if getline(1) !~ '^/// Language: DQNote-.\+'
    " Updating the format of level 1 titles.
    %s/\zs^+-\++$\n\ze//e
    %s/^| - \(.\+\) - | {{{1$\n\ze\n/[ - \1 - ] {{{1/e
    %s/^| - \(.\+\) - | {{{1$/[ - \1 - ] {{{1/e
    %s/^### \(.\+\) ### {{{1$\n\ze\n/[ - \1 - ] {{{1/e
    %s/^### \(.\+\) ### {{{1$/[ - \1 - ] {{{1/e

    " Updating the format of level 2 titles.
    %s/^--- \(.\+\) --- {{{2$\n\ze\n/=== \1 === {{{2/e
    %s/^--- \(.\+\) --- {{{2$/=== \1 === {{{2/e

    " Updating the format of level 3 titles.
    %s/^ \~\~ \(.\+\) \~\~ {{{3$\n\ze\n/  > \1 < {{{3/e
    %s/^ \~\~ \(.\+\) \~\~ {{{3$/  > \1 < {{{3/e
    %s/^\~\~\~ \(.\+\) \~\~\~ {{{3$\n\ze\n/  > \1 < {{{3/e
    %s/^\~\~\~ \(.\+\) \~\~\~ {{{3$/  > \1 < {{{3/e

    " Updating the format of subtitles (level 4 titles).
    %s/^\t\["\(.\+\)]"\( {{{4\)\=$\n\ze\n/\t[< \1]>/e
    %s/^\t\["\(.\+\)]"\( {{{4\)\=$/\t[< \1]>/e
    %s/^\["\(.\+\)]"\( {{{4\)\=$\n\ze\n/\t[< \1]>/e
    %s/^\["\(.\+\)]"\( {{{4\)\=$/\t[< \1]>/e
  endif

  " "1.2 to 1.3""
  %s/^\t\(\t*\)\[< \(.\+\)]>\ze\%( {{{4\=\)\=$/\1   |\2|/e
  try
  " These are some major areas needed to be modified
    vimgrepadd /\[< \S.\{-}]>/j %
  catch /^Vim\%((\a\+)\)\=:E480/
  endtry

  " "1.2 - 1.3 to 1.31" added dqCode syntax [\]\ and [|]|
  try
  " These are some major areas needed to be modified
    vimgrepadd /]=\['\|]'\[=/j %
  catch /^Vim\%((\a\+)\)\=:E480/
  endtry

  " "1.2 - 1.31 to 1.32" update dqnTitle1 and 2
    "Title 1
    %s/^\[ - \(.\+\) - ]\( \={{{1\)\=$/[\~{ \1 }\~]\2/e
    " Title 2
    %s/^=== \(.\+\) ===\( \={{{2\)\=$/ == \1 ==\2/e

  " Updating dqn stamp
  if getline(1) !~ '^/// Language: DQNote_1\.32$'
    if getline(1) =~ '^///.*DQNote.*$'
      call setline(1, '/// Language: DQNote_1.32')
    else
      call append(0, '/// Language: DQNote_1.32')
    endif
  endif
endfunction " dqnupdate#v1_32()

function dqnupdate#v1_33()
  " Update dqn script to v1.33
  %s/^\s*\zs##beginPython/#beginPython#/e
  %s/^\s*\zs##endPython/#endPython#/e
  " Updating dqn stamp
  if getline(1) !~ '^/// Language: DQNote_1\.33$'
    if getline(1) =~ '^///.*DQNote.*$'
      call setline(1, '/// Language: DQNote_1.33')
    else
      call append(0, '/// Language: DQNote_1.33')
    endif
  endif
endfunction " dqnupdate#v1_32()

func dqnupdate#v1_34()
  let l:et=&et
  set expandtab
  retab
  let &et=l:et
  " Updating dqn stamp
  if getline(1) !~ '^/// Language: DQNote_1\.34$'
    if getline(1) =~ '^///.*DQNote.*$'
      call setline(1, '/// Language: DQNote_1.34')
    else
      call append(0, '/// Language: DQNote_1.34')
    endif
  endif
endfunc
