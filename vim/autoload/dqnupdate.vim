" dqnupdate:     Updates DQNotes
" Maintainer:    Dexter K. Lui <dexterklui@pm.me>
" Latest Change: 13 Jun 2020
" Version:       1.35.0 (DQN v1.35)
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

func dqnupdate#v1_35()
  " Update dqn script to v1.35
  " Old escape char (dqnNomatch) escept title 1
  """""""""""""""""""""""""""""""""""""""""
  %s/^\[\~{ \(.\+\) }\~]\ze\%( \={\{3}1\)\=$/<D<T1>Q>\1<D<T1END>Q>/e
  %s+[]`]\~*\zs\~\ze[]}'\-=";/,_\\|.]+<D<NOMATCH>Q>+ge
  %s+[`[]\~*\zs\~\ze[[{'\-=";/,_\\|.]+<D<NOMATCH>Q>+ge

  " Escape {x. In new version they are highlighted but not in old version.
  """""""""""""""""""""""""""""""""""""""""
  %s+\({[/\-["'=,`_]\)+<D<TILDE>Q>\1+ge
  %s+\({{\ze[^0-9{ ]\)+<D<TILDE>Q>\1+ge
  %s+\(}[/\-\]"'=,`_]\)+<D<TILDE>Q>\1+ge
  %s+\(}}\ze[^0-9} ]\)+<D<TILDE>Q>\1+ge

  " New format for 'highlight with background'
  """""""""""""""""""""""""""""""""""""""""
  %sub+`/\(\_.\{-}\)`/+{/\1}/+ge
  %sub+`-\(\_.\{-}\)`-+{-\1}-+ge
  %sub+`\[\(\_.\{-}\)`]+{[\1}]+ge
  %sub+`{\(\_.\{-}\)`}+{{\1}}+ge
  %sub+`"\(\_.\{-}\)`"+{"\1}"+ge
  %sub+`'\(\_.\{-}\)`'+{'\1}'+ge
  %sub+`=\(\_.\{-}\)`=+{=\1}=+ge
  %sub+`;\(\_.\{-}\)`;+{;\1};+ge
  %sub+`,\(\_.\{-}\)`,+{,\1},+ge
  %sub+`_\(\_.\{-}\)`_+{_\1}_+ge

  %sub+`\\\(\_.\{-}\)`\\+{`\1}`+ge
  %sub+`|\(\_.\{-}\)`|+{/\1}/+ge

  " New format for 'code highlight'
  """""""""""""""""""""""""""""""""""""""""
  let l:reg = getreg('d')

  let @/ = '\[|\_.\{-}]|'
  normal gg0
  while 1
    normal gn"dy
    let l:str = getreg('d')
    " First handle already existing colons
    let l:str = substitute(l:str, ':', '<D<ESCCOLON>Q>', 'ge')
    " Handle Nomatch within code specially
    let l:str = substitute(l:str, '[[`]\zs<D<NOMATCH>Q>\%([/\-[{"' ."'" .'=,._]\)\@1=', '', 'ge')
    if l:str =~ '\[\\\_.\{-}]\\'
      let l:str = substitute(l:str, '\%^\[|\(.*\)]|\%$', '[\\<D<COLON>Q>\1<D<COLON>Q>]\\', 'e')
      let l:str = substitute(l:str, '.\zs\[\\\(\_.\{-}\)]\\', '<D<COLON>Q>\1<D<COLON>Q>', 'ge')
      let l:str = substitute(l:str, '<D<COLON>Q><D<COLON>Q>', '', 'ge')
    endif
    call setreg('d', l:str)
    set paste
    normal gv"dp
    set nopaste
    try
      normal n
    catch /^Vim\%((\a\+)\)\=:E385/
      break
    endtry
  endwhile

  let @/ = '\[\\\_.\{-}]\\'
  normal gg0
  while 1
    normal gn"dy
    let l:str = getreg('d')
    " First handle already existing colons
    let l:str = substitute(l:str, ':', '<D<ESCCOLON>Q>', 'ge')
    " Handle Nomatch within code specially
    let l:str = substitute(l:str, '[[`]\zs<D<NOMATCH>Q>\%([/\-[{"' ."'" .'=,._]\)\@1=', '', 'ge')
    " Translate the old format of dqnType to new dqnCodeAlt.
    let l:str = substitute(l:str, '\[|\(\_.\{-}\)]|', '<D<COLON>Q>\1<D<COLON>Q>', 'ge')
    call setreg('d', l:str)
    set paste
    normal gv"dp
    set nopaste
    try
      normal n
    catch /^Vim\%((\a\+)\)\=:E385/
      break
    endtry
  endwhile

  %s+\(\[\\\_.\{-}\)]\\\[|\(\_.\{-}\)]|+\1<D<COLON>Q>\2<D<COLON>Q>]\\+ge
  while 1
    try
      %s+\[\\\_.\{-}\zs]\\\[\\\ze\_.\{-}]\\++g
    catch /^Vim\%((\a\+)\)\=:E486/
      break
    endtry
  endwhile

  %s+<D<COLON>Q>,\( \=\)<D<COLON>Q>+`,\1+ge
  %s+<D<COLON>Q>=<D<COLON>Q>+`=+ge

  %s+\[|\(\_.\{-}\)]|+{{\1}}+ge

  call setreg('d', l:reg)

  " Handle temporary marks
  """""""""""""""""""""""""""""""""""""""""
  " <D<ESCCOLON>Q> to ~:
  %sub+<D<ESCCOLON>Q>+\~:+ge
  " <D<COLON>Q> to :
  %sub+<D<COLON>Q>+:+ge
  " <D<NOMATCH>Q> to escape char
  %sub+`<D<NOMATCH>Q>+\~{+ge
  %sub+\(.\)<D<NOMATCH>Q>+\~\1+ge
  " <D<T1>Q>TITLE1<D<T1END>Q> to title 1 format
  %sub/<D<T1>Q>\(.\+\)<D<T1END>Q>/[\~{ \1 }\~]/e
  " <D<TILDE>Q> to ~
  %sub+<D<TILDE>Q>+\~+ge

  " New indent format for unordered bullet list
  """""""""""""""""""""""""""""""""""""""""
  %s/^\%( \{4}\)\+\zs\([⮱➱‣•·+*-]\) \{3}/  \1 /e

  " Updating dqn stamp
  if getline(1) !~ '^/// Language: DQNote_1\.35$'
    if getline(1) =~ '^///.*DQNote.*$'
      call setline(1, '/// Language: DQNote_1.35')
    else
      call append(0, '/// Language: DQNote_1.35')
    endif
  endif
endfunc

" vi:fdm=indent
