" dqn2md:        Transforming format of DQN to markdown
" Maintainer:    Dexter K. Lui <dexterklui@pm.me>
" Latest Change: 26 Oct 2022
" Version:       1.35 (DQN v1.35)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TODO Python block
" TODO Picture link
" TODO In dqnCodeNrm, opened dqnCodeAlt ended by dqnCodeNrm (single colon)

" vimscript thingy {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Abort if running in vi-compatible mode or the user doesn't want us. {{{2
""""""""""""""""""""""""""""""""""""""""
if &cp || exists('g:loaded_dqn2md')
  if &cp && &verbose
    echo "Not loading dqn2md in compatible mode."
  endif
  finish
endif

" vimscript thingy {{{2
""""""""""""""""""""""""""""""""""""""""
let s:save_cpo = &cpo
set cpo&vim

" Defining functions {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text transform {{{2
""""""""""""""""""""""""""""""""""""""""
func s:EscapeChar()
" TODO Escape markdown special chararcters {{{
endfunc " }}}

func s:Title()
" Turn DQNTitles to md headings {{{
  " Handle [~{ Title_1 }~]
  %sub+^\[\~{ \(.*\) }\~].*$+# \1\r+e
  " Handle _== Title_2 == (_ is a sapce)
  %sub+^ == \(.*\) ==.*$+## \1\r+e
  " Handle __> Title_3 < (_ is a sapce)
  %sub+^  > \(.*\) <.*$+### \1\r+e
  " Handle ___|Title_4| (_ is a sapce)
  %sub+^   |\(.*\)|.*$+#### \1\r+e
endfunc " }}}

func s:Paragraph()
  " turns a series of blank lines to a single blank line {{{
  %sub+\(^\s*$\n\)\{2,}+\r+ge
  %sub+^ \{4}++e

  " joining paragraphs
  exe "normal Go\<Esc>"
  g/^\s*\S/ .,/^$/-1 join

  " remove blank lines between list items
  %s/\( \{4}\)*[*+-]\s\+\S\+.*\n\zs\n\ze\( \{4}\)*[*+-]\s\+\S\+//e
  %s/\( \{4}\)*\d\+[.]\s\+\S\+.*\n\zs\n\ze\( \{4}\)*\d\+[.]\s\+\S\+//e
  %s/\( \{4}\)*[*+-]\s\+\S\+.*\n\zs\n\ze\( \{4}\)*\d\+[.]\s\+\S\+//e
  %s/\( \{4}\)*\d\+[.]\s\+\S\+.*\n\zs\n\ze\( \{4}\)*[*+-]\s\+\S\+//e
endfunc " }}}

func s:Keyword()
" Highlight DQN keywords {{{
  %sub+\<\(DUNNO\|NOTE\|WARNI\=N\=G\=\|TODO\|XXX\|FIXME\)\>\|/?/
        \+***\1***+ge
endfunc " }}}

func s:OrderedList()
" Turn ordered list into md format {{{
  %s/^\ze\( \{4}\)\+\d[.)]\s\+\S\+/\r/e
  %s/^\( \{4}\)\+\d\zs)\ze\s\+\S\+/./e

endfunc " }}}

func s:UnorderedList()
" Turn unordered list into md format {{{
  %s/^\( \{4}\)\+\zs\ze\a[.)]\s\+\S\+/➱   /e " Turn letter listed into unordered list by prepending ➱

  %s/^\ze\( \{4}\)\+[·•‣➱⮱-]\s\+\S\+/\r/e
  %s/^\( \{4}\)\+\zs[·•‣➱⮱-]\ze\s\+\S\+/-/e
endfunc " }}}

func s:Highlight()
" Turn DQN highlights to md format {{{
  %sub+\[\[\(\_.\{-}\)]]+**\1**+ge
  %sub+\[{\(\_.\{-}\)]}+_\1_+ge
  %sub+\['\(\_.\{-}\)]'+[[\1]]+ge
  %sub+\[-\(\_.\{-}\)]-+**\1**+ge
  %sub+\[=\(\_.\{-}\)]=+_\1_+ge
  %sub+\["\(\_.\{-}\)]"+_\1_+ge
  %sub+\[;\(\_.\{-}\)];+***\1***+ge
  %sub+\[/\(\_.\{-}\)]/+***\1***+ge
  "%sub+\[,\(\_.\{-}\)],+\1+ge
  "%sub+\[_\(\_.\{-}\)]_+\1+ge

  "%sub+`\[\(\_.\{-}\)`]+**\1**+ge
  "%sub+`{\(\_.\{-}\)`}+**\1**+ge
  "%sub+`'\(\_.\{-}\)`'+**\1**+ge
  "%sub+`-\(\_.\{-}\)`-+**\1**+ge
  "%sub+`=\(\_.\{-}\)`=+**\1**+ge
  "%sub+`"\(\_.\{-}\)`"+**\1**+ge
  "%sub+`;\(\_.\{-}\)`;+**\1**+ge
  "%sub+`/\(\_.\{-}\)`/+**\1**+ge
  "%sub+`,\(\_.\{-}\)`,+**\1**+ge
  "%sub+`_\(\_.\{-}\)`_+**\1**+ge
  "%sub+`\\\(\_.\{-}\)`\\+**\1**+ge
  "%sub+`|\(\_.\{-}\)`|+**\1**+ge
endfunc " }}}

func s:Code()
" Turn DQN code to md format {{{
  " Remove extra tild (escape character) FIXME not entirely correct
  g/\[\\.*]\\/sub+\~\ze\(\~\|:\||\)++ge
  %sub+\[\\\(\_.\{-}\)]\\+`\1`+ge
endfunc " }}}

func s:SeparateLine()
" Keep lines in certain area separated {{{
  %sub/░$/\r/ge
  %sub/:$/:\r/ge
  %sub/^\(=\{70,78}\)$/\r\1\r/ge
  %sub/^\(-\{70,78}\)$/\r\1\r/ge
  %sub+^\(/\*-\{74}\*/\)$+\r\1\r+ge
endfunc " }}}

func s:Hyperlink()
" Make hyperlink {{{
  " FIXME What if the link breaks to several lines?
  %sub+\[=\(https\=://\S\{-}\)]=+<\1>+ge
endfunc " }}}

func s:Image()
" Insert images {{{
  %sub/^{D{IMG}Q}\(.\+\)$/![\1](\1)/e
endfunc " }}}

func s:PreDelete()
" Delete unwanted elements and replace some with temporary marks {{{
  %sub+\%^/// Language: DQNote_\d\+.*\n++e
  %sub+{\{3}\d\=\s*++ge
  %sub+}\{3}\d\=\s*++ge

  %sub/<IMG:\([^>]\{-}\)>/\r{D{IMG}Q}\1\r/ge
endfunc " }}}

func s:PostDelete()
" Delete unwanted elements {{{
  %sub+\[\.\_.\{-}]\.++ge

  " Remove dqnNomatch (escape char which prevents matching dqn highlighting)
  " XXX From dqn2html, dunno if needed
  %sub+[[`]\~*\zs\~\ze[[{'"-=";/,_\\|.]++ge
  %sub+[]`]\~*\zs\~\ze[]}'"-=";/,_\\|.]++ge
  %sub+\[\~*\zs\~\ze\[++ge
  %sub+]\~*\zs\~\ze]++ge

  " XXX From dqn2html, dunno if needed
  %g/\[\\/sub+[{}]\zs\~++ge
endfunc " }}}

func s:Replace()
" Replace temporary mark with correct string {{{
endfunc " }}}

func s:Md()
" Transform text to md {{{
  call s:EscapeChar()
  call s:PreDelete()
  call s:Title()
  call s:Keyword()
  call s:Hyperlink()
  call s:Image()
  call s:Highlight()
  call s:PostDelete()
  call s:SeparateLine()
  call s:UnorderedList()
  call s:OrderedList()
  call s:Paragraph()
  call s:Replace()
endfunc " }}}

" Others {{{2
""""""""""""""""""""""""""""""""""""""""
func Dqn2MdOverwrite() range abort
" Translate and (over)write md file at directory of the dqn file. {{{
  if DQNVersion() == -1
    echoe 'This is not a dqn file! Abort function.'
    return
  endif

  update

  let l:md_file_path = expand("%:p:r") . '.md'
  try
    exe "saveas! " . l:md_file_path
  catch /^Vim\%((\a\+)\)\=:E139:/
    exe 'bdelete ' . l:md_file_path
    exe "saveas! " . l:md_file_path
  endtry
  call s:Md()
  update

  set filetype=markdown
endfunc " }}}

func Dqn2Md() range abort
" Translate and create new md file at directory of the dqn file. {{{
  if DQNVersion() == -1
    echoe 'This is not a dqn file! Abort function.'
    return
  endif

  let l:md_file = expand("%:t:r") . '.md'
  let l:md_file_path = expand("%:p:r") . '.md'
  if filereadable(l:md_file_path)
    echoe l:md_file . ' already exists! Abort function.'
    return
  endif

  update

  exe "saveas " . l:md_file_path
  call s:Md()
  update

  set filetype=markdown
endfunc " }}}

" Defining commands and mappings {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Defining commands {{{2
""""""""""""""""""""""""""""""""""""""""
command Dqn2md call Dqn2Md()
command Dqn2mdoverwrite call Dqn2MdOverwrite()

" vimscript thingy    {{{1
let &cpo = s:save_cpo
unlet s:save_cpo
let g:loaded_dqn2md = 1

" TODO Remove unwanted sections

" vim:set sw=2 sts=2 fdm=marker:
