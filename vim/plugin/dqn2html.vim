" dqn2html:       Transforming format of DQN to html
" Maintainer:    Dexter K. Lui <dexterklui@pm.me>
" Latest Change: 26 May 2020
" Version:       1.33.02 (DQN v1.33)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TODO Python block
" TODO Picture link

" vimscript thingy {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Abort if running in vi-compatible mode or the user doesn't want us. {{{2
""""""""""""""""""""""""""""""""""""""""
if &cp || exists('g:loaded_dqn2html')
  if &cp && &verbose
    echo "Not loading dqn2html in compatible mode."
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
" Escape html special char < and & {{{
  %sub+&+\&amp;+ge
  %sub+<+\&lt+ge
endfunc " }}}

func s:Title()
" Turn DQNTitles to html headings {{{
  " Handle [~{ Title_1 }~]
  %sub+^\[\~{ \(.*\) }\~].*$+    <h1>[\~{ \1 }\~]</h1>+ge
  " Handle _== Title_2 == (_ is a sapce)
  %sub+^ == \(.*\) ==.*$+    <h2>== \1 ==</h2>+ge
  " Handle __> Title_3 < (_ is a sapce)
  %sub+^  > \(.*\) &lt.*$+    <h3>> \1 \&lt</h3>+ge
  " Handle ___|Title_4| (_ is a sapce)
  %sub+^   |\(.*\)|.*$+    <h4>|\1|</h4>+ge
endfunc " }}}

func s:Paragraph()
" TODO Separate paragraphs ?(and handle indent)? {{{
  " This must run after s:Title to utilize blank lines created by it
  " TODO What if blank lines connected a line with only <br> (like created in
  " list)?

  " turns a series of empty lines and lines containing only <br> to a single
  " line with <br> XXX
  %sub+\%(\n\s*\)*\%(\n\s*\%(<br>\)\+\)\+\n+    <br>+ge

  " turns a series of blank lines to a single line and break paragraph
  %sub+\%(\n\s*\)\+\n+    </p><p>+ge

  "%sub+^\s*</p><p>\n\ze\s*<br>++ge

  " Change position of </**> that immediately follows </p><p> to immediately
  " be4
  %sub&^\(\s*\)</p><p>\n\(\s*\)\(\%(</[^>]\+>\)\+\)&\1\3</p><p>\2&ge
endfunc " }}}

func s:Keyword()
" Highlight DQN keywords {{{
  %sub+\<\(DUNNO\|NOTE\|WARN\|TODO\|XXX\|FIXME\)\>\|/?/+<font color="#e4569b"><b>\1</b></font>+ge
endfunc " }}}

func s:char1_col(line, regexp, has_index)
" Return the virtcol of the first nonspace char after list index (if any) {{{
  " TODO what if a:line == 1?
  call cursor(a:line-1,1)

  let _ = escape(a:regexp, '/')

  if a:has_index
    exe '/^\s*\%(<br>\)*' ._ .'\s*\zs.*'
  elseif match(getline(a:line), '^\s') == -1
    return 1
  else
    exe '/^\s*\zs'
  endif
  normal 0n
  return virtcol('.')
endfunc " }}}

func s:OrderedList()
" TODO Turn ordered list into html format {{{
  " Create a pattern for mattching ordered list index
  let l:list = ['(\=\d\+)', '\d\+\.']
  let l:regexp = '\('
  for i in l:list
    let l:regexp .= i . '\|'
  endfor
  let l:regexp = substitute(l:regexp, '\\\zs|$', ')', '')

  let l:had_index = 0
  let l:list_lv = 0
  let _ = escape(l:regexp, '&')
  for i in range(1, line('$'))
    " if no list was started & has no index, ignore
    """"""""""""""""""""""""""""""
    " TODO calculate indent lv and whether has index right at start b4 if loop
    " Ignore html </li> </ul> for this func runs after Unordered list
    if !l:list_lv && getline(i) !~# '^\s*' .'\%(</li>\|</ul>\)*' .l:regexp
      continue

    " if no list was started (& has index): start outter most list
    """"""""""""""""""""""""""""""
    elseif !l:list_lv
      let l:had_index = 1
      let l:list_lv += 1
      exe 'let l:char1_col_' .l:list_lv .' = s:char1_col(i, l:regexp, 1)'
      exe i .'sub&^\s*\%(</li>\|</ul>\|</p>\|<p>\)*\zs' ._ .'\s*&<ol><li>'

    " Form Now On: list(s) was/were started

    " if is blank line, add line break if not already added in this series of
    " blank lines
    """"""""""""""""""""""""""""""
    " TODO What if I want a paragraph break? Is it possible to distinguish?
    elseif getline(i) =~# '^\s*$'
      let l:had_index = 0
      if getline(i-1) =~# '<br>$'
	exe i-1 'sub/\s*<br>$/'
      endif
      " TODO add indent to <br> and all others with 4 spaces front
      exe i .'sub/^\s*$/    <br>'

    " if is has <br> only, remove extra <br> in previous line.
    """"""""""""""""""""""""""""""
    elseif getline(i) =~# '^\s*<br>$'
      let l:had_index = 0
      if getline(i-1) =~# '<br>$'
	exe i-1 'sub/\s*<br>$/'
      endif

    " if no index
    """"""""""""""""""""""""""""""
    elseif getline(i) !~# '^\s*' .'\%(</li>\|</ul>\|</p>\|<p>\)*' .l:regexp
      " If the line above was a list, add a line break if not already exist.
      if l:had_index
	exe i-1 .'sub&\s*\%(<br>\)*$&<br>'
      endif
      let l:had_index = 0

      let l:char1_col_current = s:char1_col(i, l:regexp, 0)
      " check upwards if it belongs to a list. End finished list in process
      while l:list_lv >= 1
	if l:char1_col_current >= eval('l:char1_col_' .l:list_lv)
	  break
	else
	  let l:list_lv -= 1
	  if l:list_lv > 0
	    exe i .'sub&^\s*\%(</li>\|</ul>\|</p>\|<p>\|</ol>\)*\zs&</li></ol>'
	  else
	    exe i .'sub&^\s*\%(</li>\|</ul>\|</p>\|<p>\|</ol>\)*\zs&</li></ol></p><p>'
	  endif
	endif
      endwhile

    " From Now On: has index

    " if on same list level as previous item, set new list item
    """"""""""""""""""""""""""""""
    elseif s:char1_col(i, l:regexp, 1) == eval('l:char1_col_' .l:list_lv)
      let l:had_index = 1
      exe i .'sub&^\s*\%(</li>\|</ul>\|</p>\|<p>\)*\zs' ._ .'\s*&</li><li>'

    " if on higher list level (i.e. smaller indent lv)
    """"""""""""""""""""""""""""""
    elseif s:char1_col(i, l:regexp, 1) < eval('l:char1_col_' .l:list_lv)
      let l:had_index = 1
      let l:char1_col_current = s:char1_col(i, l:regexp, 1)

      " if even higher list lv than outter most existing list, create new list
      if l:char1_col_current < l:char1_col_1
	let l:list_lv = 1
	exe 'let l:char1_col_' .l:list_lv .' = l:char1_col_current'
	exe i .'sub&^\s*\%(</li>\|</ul>\|</p>\|<p>\)*\zs' ._ .'\s*&<ol><li>'
      else " set a new list item
	exe i .'sub&^\s*\%(</li>\|</ul>\|</p>\|<p>\)*\zs' ._ .'\s*&<li>'
      endif

      " check upwards and end finished list in process
      while l:list_lv >= 1
	if l:char1_col_current >= eval('l:char1_col_' .l:list_lv)
	  break
	else
	  let l:list_lv -= 1
	  if l:list_lv > 0
	    exe i .'sub&^\s*\%(</li>\|</ul>\|</p>\|<p>\|</ol>\)*\zs&</li></ol>'
	  else
	    exe i .'sub&^\s*\%(</li>\|</ul>\|</p>\|<p>\|</ol>\)*\zs&</li></ol></p><p>'
	  endif
	endif
      endwhile

    " From Now On: has lower list level  (i.e. greater indent lv)
    """"""""""""""""""""""""""""""
    else
      let l:had_index = 1
      " TODO Now always assume start a new list
      let l:list_lv += 1
      exe 'let l:char1_col_' .l:list_lv .' = s:char1_col(i, l:regexp, 1)'
      exe i .'sub&^\s*\%(</li>\|</ul>\|</p>\|<p>\)*\zs' ._ .'\s*&<ol><li>'
    endif
  endfor
endfunc " }}}

func s:UnorderedList()
" Turn unordered list into html format {{{
  let l:bullet = ['⮱', '➱', '‣', '·', '+', '*', '-']
  let l:regexp = '\('
  for i in l:bullet
    let l:itempat = escape(i, '[\*.~')
    " TODO no need if statement. Use substitute+\\\zs|$+)
    let l:regexp .= l:itempat . '\|'
  endfor
  let l:regexp = substitute(l:regexp, '\\\zs|$', ')', '')

  let l:list_lv = 0
  let _ = escape(l:regexp, '/')
  for i in range(1, line('$'))
    " if no list was started & has no index, ignore
    """"""""""""""""""""""""""""""
    " TODO calculate indent lv and whether has index right at start b4 if loop
    if !l:list_lv && getline(i) !~# '^\s*' .l:regexp
      continue

    " if no list was started (& has index): start outter most list
    """"""""""""""""""""""""""""""
    elseif !l:list_lv
      let l:had_index = 1
      let l:list_lv += 1
      exe 'let l:char1_col_' .l:list_lv .' = s:char1_col(i, l:regexp, 1)'
      exe i .'sub/^\s*\zs' ._ .'\s*/<ul><li>'

    " Form Now On: list(s) was/were started

    " if is blank line, add line break if not already added in this series of
    " blank lines
    """"""""""""""""""""""""""""""
    " TODO What if I want a paragraph break? Is it possible to distinguish?
    elseif getline(i) =~# '^\s*$'
      let l:had_index = 0
      if getline(i-1) =~# '<br>$'
	exe i-1 'sub/\s*<br>$/'
      endif
      " TODO add indent to <br> and all others with 4 spaces front
      exe i .'sub/^\s*$/    <br>'

    " if is has <br> only, remove extra <br> in previous line.
    """"""""""""""""""""""""""""""
    elseif getline(i) =~# '^\s*<br>$'
      let l:had_index = 0
      if getline(i-1) =~# '<br>$'
	exe i-1 'sub/\s*<br>$/'
      endif

    " if no index
    """"""""""""""""""""""""""""""
    elseif getline(i) !~# '^\s*' .l:regexp
      " If the line above was a list, add a line break if not already exist.
      if l:had_index
	exe i-1 .'sub&\s*\%(<br>\)*$&<br>'
      endif
      let l:had_index = 0

      let l:char1_col_current = s:char1_col(i, l:regexp, 0)
      " check upwards if it belongs to a list. End finished list in process
      while l:list_lv >= 1
	if l:char1_col_current >= eval('l:char1_col_' .l:list_lv)
	  break
	else
	  let l:list_lv -= 1
	  if l:list_lv > 0
	    exe i .'sub&^\s*\%(</li>\|</ul>\|</p>\|<p>\)*\zs&</li></ul>'
	  else
	    exe i .'sub&^\s*\%(</li>\|</ul>\|</p>\|<p>\)*\zs&</li></ul></p><p>'
	  endif
	endif
      endwhile

      " If the line above was a list, add a line break if not already exist.
      if getline(i-1) =~# '^\s*' .'\%(</li>\|</ul>\)*' .l:regexp
	exe i-1 .'sub&\s*<br>*$&<br>'
      endif

    " From Now On: has index

    " if on same list level as previous item, set new list item
    """"""""""""""""""""""""""""""
    elseif s:char1_col(i, l:regexp, 1) == eval('l:char1_col_' .l:list_lv)
      let l:had_index = 1
      exe i .'sub/^\s*\zs\%(<br>\)*' ._ .'\s*/<\/li><li>'

    " if on higher list level (i.e. smaller indent lv)
    """"""""""""""""""""""""""""""
    elseif s:char1_col(i, l:regexp, 1) < eval('l:char1_col_' .l:list_lv)
      let l:had_index = 1
      let l:char1_col_current = s:char1_col(i, l:regexp, 1)

      " if even higher list lv than outter most existing list, create new list
      if l:char1_col_current < l:char1_col_1
	let l:list_lv = 1
	exe 'let l:char1_col_' .l:list_lv .' = l:char1_col_current'
	exe i .'sub/^\s*\zs\%(<br>\)*' ._ .'\s*/<ul><li>'
      else " set a new list item
	exe i .'sub/^\s*\zs\%(<br>\)*' ._ .'\s*/<li>'
      endif

      " check upwards and end finished list in process
      while l:list_lv >= 1
	if l:char1_col_current >= eval('l:char1_col_' .l:list_lv)
	  break
	else
	  let l:list_lv -= 1
	  if l:list_lv > 0
	    exe i .'sub&^\s*\%(</li>\|</ul>\|</p>\|<p>\)*\zs&</li></ul>'
	  else
	    exe i .'sub&^\s*\%(</li>\|</ul>\|</p>\|<p>\)*\zs&</li></ul></p><p>'
	  endif
	endif
      endwhile

    " From Now On: has lower list level  (i.e. greater indent lv)
    """"""""""""""""""""""""""""""
    else
      let l:had_index = 1
      " TODO Now always assume start a new list
      let l:list_lv += 1
      exe 'let l:char1_col_' .l:list_lv .' = s:char1_col(i, l:regexp, 1)'
      exe i .'sub/^\s*\zs\%(<br>\)*' ._ .'\s*/<ul><li>'
    endif
  endfor
endfunc " }}}

func s:Highlight()
" Turn DQN highlights to html format {{{
  %sub+\[\[\(\_.\{-}\)]]+<font color="#b58900">\1</font>+ge
  %sub+\[{\(\_.\{-}\)]}+<font color="#859900">\1</font>+ge
  %sub+\['\(\_.\{-}\)]'+<font color="#409ee0">\1</font>+ge
  %sub+\[-\(\_.\{-}\)]-+<font color="#e06431">\1</font>+ge
  %sub+\[=\(\_.\{-}\)]=+<font color="#6c71c4">\1</font>+ge
  %sub+\["\(\_.\{-}\)]"+<font color="#2aa198">\1</font>+ge
  %sub+\[;\(\_.\{-}\)];+<font color="#e4569b">\1</font>+ge
  %sub+\[/\(\_.\{-}\)]/+<font color="#dc322f">\1</font>+ge
  %sub+\[,\(\_.\{-}\)],+<font color="#cbd4d4">\1</font>+ge
  %sub+\[_\(\_.\{-}\)]_+<font color="#fcf8ee">\1</font>+ge
  %sub+\[\\\(\_.\{-}\)]\\+<font color="#073642"><code>\1</code></font>+ge
  %sub+\[|\(\_.\{-}\)]|+<font color="#dc322f"><code>\1</code></font>+ge

  %sub+`\[\(\_.\{-}\)`]+<font color="#b58900" style="background-color: #cbd4d4">\1</font>+ge
  %sub+`{\(\_.\{-}\)`}+<font color="#859900" style="background-color: #cbd4d4">\1</font>+ge
  %sub+`'\(\_.\{-}\)`'+<font color="#409ee0" style="background-color: #cbd4d4">\1</font>+ge
  %sub+`-\(\_.\{-}\)`-+<font color="#e06431" style="background-color: #cbd4d4">\1</font>+ge
  %sub+`=\(\_.\{-}\)`=+<font color="#6c71c4" style="background-color: #cbd4d4">\1</font>+ge
  %sub+`"\(\_.\{-}\)`"+<font color="#2aa198" style="background-color: #cbd4d4">\1</font>+ge
  %sub+`;\(\_.\{-}\)`;+<font color="#e4569b" style="background-color: #cbd4d4">\1</font>+ge
  %sub+`/\(\_.\{-}\)`/+<font color="#dc322f" style="background-color: #cbd4d4">\1</font>+ge
  %sub+`,\(\_.\{-}\)`,+<font color="#cbd4d4" style="background-color: #cbd4d4">\1</font>+ge
  %sub+`_\(\_.\{-}\)`_+<font color="#fcf8ee" style="background-color: #cbd4d4">\1</font>+ge
  %sub+`\\\(\_.\{-}\)`\\+<font color="#073642"><code>\1</code></font>+ge
  %sub+`|\(\_.\{-}\)`|+<font color="#dc322f"><code>\1</code></font>+ge
endfunc " }}}

func s:SeparateLine()
" Keep lines in certain area separated {{{
  %sub/░$/<br>/ge
  %sub/:$/:<br>/ge
  %sub/^\(=\{70,78}\)$/\1/ge
  %sub/^\(-\{70,78}\)$/\1/ge
  %sub+^\(/\*-\{74}\*/\)$+\1+ge
endfunc " }}}

func s:Hyperlink()
" Make hyperlink {{{
  " FIXME What if the link breaks to several lines?
  %sub+\[=\(https\=://\S\{-}\)]=+<a href="\1">\1</a>+ge
endfunc " }}}

func s:PreDelete()
" Delete unwanted elements {{{
  %sub+\%^/// Language: DQNote_\d\+.*\n++e
  %sub+{\{3}\d\=\s*++ge
  %sub+}\{3}\d\=\s*++ge
endfunc " }}}

func s:PostDelete()
" Delete unwanted elements {{{
  %sub+\[\.\_.\{-}]\.++ge

  " Remove dqnNomatch (escape char which prevents matching dqn highlighting)
  %sub+[[`]\~*\zs\~\ze[[{'"-=";/,_\\|.]++ge
  %sub+[]`]\~*\zs\~\ze[]}'"-=";/,_\\|.]++ge
  %sub+\[\~*\zs\~\ze\(\[\|<font color\)++ge
  %sub+]\~*\zs\~\ze\(]\|</font>\)++ge
endfunc " }}}

func s:Html()
" Transform text to html {{{
  call s:PreDelete()
  call s:EscapeChar()
  call s:Title()
  call s:Keyword()
  call s:Hyperlink()
  call s:Highlight()
  call s:PostDelete()
  call s:SeparateLine()
  call s:UnorderedList()
  call s:OrderedList()
  call s:Paragraph()
endfunc " }}}

" Others {{{2
""""""""""""""""""""""""""""""""""""""""
func s:CreateTmp() range
" Edit a file in /tmp/ {{{
  silent !mkdir -p /tmp/dqn2html/
  let l:fname = substitute(expand('%:p:r'), '[^/]\zs/', '\\%', 'ge')
  echom a:firstline .',' .a:lastline .'w! /tmp/dqn2html' .l:fname .'.html'
  exe a:firstline .',' .a:lastline .'w! /tmp/dqn2html' .l:fname .'.html'

  exe 'edit /tmp/dqn2html/' .l:fname .'.html'
endfunc " }}}

func s:HtmlSkeleton()
" Create html skeleton and head {{{
  call append(0, "<html>")
  call append(1, "  <head>")
  call append(2, "    <title>" . expand('%:t:r') . "</title>")
  call append(3, "    <style>")
  call append(4, "    body {background: #fcf8ee; padding-left: 10px}")
  call append(5, "    p {width: 40em; color: #5d727a; text-align: justify; text-justify: inter-word;}")
  call append(6, "    h1 {color: #af5faf; text-align: center; font-size: 130%;}")
  call append(7, "    h2 {color: #af5f00; font-size: 120%;}")
  call append(8, "    h3 {color: #008787; font-size: 110%; padding: 0; margin: 0;}")
  call append(9, "    h4 {color: #0087b7; font-size: 100%; padding: 0; margin: 0;}")
  call append(10, "    code {background-color: #ebe9e4; font-size: 105%}")
  call append(11, "    ol {}")
  call append(12, "    ul {}")
  call append(13, "    li {width: 40em; color: #5d727a; text-align: justify; text-justify: inter-word}")
  call append(14, "    </style>")
  call append(15, "  </head>")
  call append(16, "  <body>")
  call append(line('$'), "  </body>")
  call append(line('$'), "</html>")
endfunc " }}}

func Dqn2html() range abort
" Write content in /tmp/, and change format to HTML {{{
" open: {0|1}: 1:open the HTML file in a browser
  if DQNVersion() == 0
    echoe 'This is not a dqn file! Abort function.'
    return
  endif
  update
  let l:altbuf = @#
  exe a:firstline .',' .a:lastline .'call s:CreateTmp()'
  call s:Html()
  call s:HtmlSkeleton()
  update
  let @# = l:altbuf
endfunc " }}}

func Opendqnhtml()
" Open the corresponding html file for current dqn {{{
  let l:altbuf = @#
  if expand('%:p') =~# '^/tmp/dqn2html/.*\.html$'
    let l:fname = substitute(expand('%:p:r'), '^/tmp/dqn2html', '', '')
    exe 'e ' .substitute(l:fname, '%', '/', 'ge') .'.dqn'
  elseif expand('%:e') =~# '^dqn\~\=$'
    let l:fname = substitute(expand('%:p:r'), '[^/]/', '\\%', 'ge')
    exe 'e /tmp/dqn2html' .l:fname .'.html'
  endif
  let @# = l:altbuf
endfunc " }}}

" Defining commands and mappings {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Defining commands {{{2
""""""""""""""""""""""""""""""""""""""""
command -range=% Dqn2html exe 'silent <line1>,<line2>call Dqn2html()'
  \ | exe 'silent !xdg-open %&' | call Opendqnhtml()
command -range=% Reloadhtml exe 'silent <line1>,<line2>call Dqn2html()'
  \ | call Opendqnhtml()

" mappings {{{2
""""""""""""""""""""""""""""""""""""""""

" vimscript thingy    {{{1
let &cpo = s:save_cpo
unlet s:save_cpo
let g:loaded_dqn2html = 1

" TODO Remove unwanted sections

" vim:set sw=2 sts=2 fdm=marker:
