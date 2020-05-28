" dqn2html:       Transforming format of DQN to html
" Maintainer:    Dexter K. Lui <dexterklui@pm.me>
" Latest Change: 26 May 2020
" Version:       1.33.01 (DQN v1.33)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
    if i != l:list[-1]
      let l:regexp .= i . '\|'
    else
      let l:regexp .= i . '\)'
    endif
  endfor

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
    if i != l:bullet[-1]
      let l:regexp .= l:itempat . '\|'
    else
      let l:regexp .= l:itempat . '\)'
    endif
  endfor

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

func s:Highlight(accurate)
" Turn DQN highlights to html format {{{
" Accurate but much slower method
""""""""""""""""""""""""""""""""""""""""
if a:accurate == 1
  " generate pattern
  let l:hl = {'[':']',
    \ '{':'}',
    \ "'":"'",
    \ '-':'-',
    \ '=':'=',
    \ '"':'"',
    \ ';':';',
    \ '/':'/',
    \ ',':',',
    \ '_':'_',
    \ '\':'\',
    \ '|':'|',
    \ }
  let l:hl_beg_pat = '\('
  for i in keys(l:hl)
    let l:itempat = escape(i, '[\*.~')
    let l:hl_beg_pat .= l:itempat .'\|'
  endfor
  let l:hl_beg_pat = substitute(l:hl_beg_pat, '\\\zs|$', ')', '')

  let l:hl_end_pat = '\('
  for i in keys(l:hl)
    let l:item = eval('l:hl["' .escape(i, '"\') .'"]')
    let l:itempat = escape(l:item, '[\*.~')
    let l:hl_end_pat .= l:itempat .'\|'
  endfor
  let l:hl_end_pat = substitute(l:hl_end_pat, '\\\zs|$', ')', '')

  call cursor(1,1)
  let g:wrapscan = &wrapscan
  let l:reg = @*
  set nowrapscan
  let l:fo = &fo
  let &fo=''
  " Find beginning of dqn highlight region, replace to <font color=..>, then
  " jump to corresponding end of dqn highlight region, replace to </font>.
  " Repeat until hit file bottom
  while 1
    let @/ = '\[' .l:hl_beg_pat
    try
      normal nlv"*y
      let l:key = getreg('*')
      let l:item = eval('l:hl["' .escape(l:key, '"\') .'"]')
      let l:endpat = ']' .escape(l:item, '[\*.~')

      " Change begin first pattern first
      if l:key ==# '['
	normal vhc<font color="#b58900">
      elseif l:key ==# '{'
	normal vhc<font color="#859900">
      elseif l:key ==# "'"
	normal vhc<font color="#268bd2">
      elseif l:key ==# '-'
	normal vhc<font color="#e06431">
      elseif l:key ==# '='
	normal vhc<font color="#6c71c4">
      elseif l:key ==# '"'
	normal vhc<font color="#2aa198">
      elseif l:key ==# ';'
	normal vhc<font color="#e4569b">
      elseif l:key ==# '/'
	normal vhc<font color="#dc322f">
      elseif l:key ==# ','
	normal vhc<font color="#cbd4d4">
      elseif l:key ==# '_'
	normal vhc<font color="#fcf8ee">
      elseif l:key ==# '\'
	normal vhc<font color="#073642"><code>
      elseif l:key ==# '|'
	normal vhc<font color="#dc322f"><code>
      endif
      
      let @/ = l:endpat
      normal n
      " change end pattern
      if l:key ==# '['
	normal vlc</font>
      elseif l:key ==# '{'
	normal vlc</font>
      elseif l:key ==# "'"
	normal vlc</font>
      elseif l:key ==# '-'
	normal vlc</font>
      elseif l:key ==# '='
	normal vlc</font>
      elseif l:key ==# '"'
	normal vlc</font>
      elseif l:key ==# ';'
	normal vlc</font>
      elseif l:key ==# '/'
	normal vlc</font>
      elseif l:key ==# ','
	normal vlc</font>
      elseif l:key ==# '_'
	normal vlc</font>
      elseif l:key ==# '\'
	normal vlc</code></font>
      elseif l:key ==# '|'
	normal vlc</code></font>
      endif

    catch /^Vim\%((\a\+)\)\=:E385/
      break
    endtry
  endwhile
  let &fo = l:fo
  let &wrapscan = g:wrapscan
  let @* = l:reg
  "

" TODO accurate and fast
""""""""""""""""""""""""""""""""""""""""
"elseif a:accurate == 2

" Falsely add unwanted hl in already hl'ed area but is a much faster method
""""""""""""""""""""""""""""""""""""""""
else
  %sub+\[\[\(\_.\{-}\)]]+<font color="#b58900">\1</font>+ge
  %sub+\[{\(\_.\{-}\)]}+<font color="#859900">\1</font>+ge
  %sub+\['\(\_.\{-}\)]'+<font color="#268bd2">\1</font>+ge
  %sub+\[-\(\_.\{-}\)]-+<font color="#e06431">\1</font>+ge
  %sub+\[=\(\_.\{-}\)]=+<font color="#6c71c4">\1</font>+ge
  %sub+\["\(\_.\{-}\)]"+<font color="#2aa198">\1</font>+ge
  %sub+\[;\(\_.\{-}\)];+<font color="#e4569b">\1</font>+ge
  %sub+\[/\(\_.\{-}\)]/+<font color="#dc322f">\1</font>+ge
  %sub+\[,\(\_.\{-}\)],+<font color="#cbd4d4">\1</font>+ge
  %sub+\[_\(\_.\{-}\)]_+<font color="#fcf8ee">\1</font>+ge
  %sub+\[\\\(\_.\{-}\)]\\+<font color="#073642"><code>\1</code></font>+ge
  %sub+\[|\(\_.\{-}\)]|+<font color="#dc322f"><code>\1</code></font>+ge

endif
  " TODO Remaining color with background
endfunc " }}}

func s:SeparateLine()
" Keep lines in certain area separated {{{
  %sub/░$/<br>/ge
  %sub/:$/:<br>/ge
endfunc " }}}

func s:Hyperlink()
" TODO Make hyperlink {{{
  return
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
endfunc " }}}

func s:Html(accurate)
" Transform text to html {{{
  call s:PreDelete()
  call s:EscapeChar()
  call s:Title()
  call s:Highlight(a:accurate)
  call s:PostDelete()
  call s:SeparateLine()
  call s:UnorderedList()
  call s:OrderedList()
  call s:Paragraph()
endfunc " }}}

" Others {{{2
""""""""""""""""""""""""""""""""""""""""
func s:CreateTmp()
" Edit a file in /tmp/ {{{
" TODO change saveas to edit. Then later only paste a selected range rather
" than a whole file
  silent! mkdir -p /tmp/dqn2html/
  exe 'saveas! /tmp/dqn2html/' .expand('%:p:h:h:t') .'\%'
    \ .expand('%:p:h:t') .'\%' .expand('%:t:r') . '.html'
endfunc " }}}

func s:HtmlSkeleton()
" Create html skeleton and head {{{
  call append(0, "<html>")
  call append(1, "  <head>")
  call append(2, "    <title>" . expand('%:t:r') . "</title>")
  call append(3, "    <style>")
  call append(4, "    body {background: #fcf8ee; padding-left: 10px}")
  call append(5, "    p {width: 40em; color: #5d727a; text-align: justify; text-justify: inter-word;}")
  call append(6, "    h1 {color: #3e5963;}")
  call append(7, "    h2 {color: #3e5963;}")
  call append(8, "    h3 {color: #3e5963;}")
  call append(9, "    h4 {color: #3e5963;}")
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

func Dqn2html(accurate, open) range abort
" Write content in /tmp/, and change format to HTML {{{
" accurate: {0|1}: 0:faster but may wrongly highlight more words
" open: {0|1}: 1:open the HTML file in a browser
  if DQNVersion() == 0
    echoe 'This is not a dqn file! Abort function.'
    return
  endif
  update
  if !(a:firstline == a:lastline && a:firstline == line('.'))
    let l:reg = @*
    '<,'>yank *
  endif
  let l:altbuf = bufnr(@#)
  call s:CreateTmp()
  if !(a:firstline == a:lastline && a:firstline == line('.'))
    normal gg0dG"*pggdd
    let @* = l:reg
  endif

  " TODO add silent
  call s:Html(a:accurate)
  call s:HtmlSkeleton()

  update
  if a:open == 1
    silent !xdg-open %&
  endif
  buffer #
  let @# = l:altbuf
endfunc " }}}

func Opendqnhtml()
" Open the corresponding html file for current dqn {{{
  if expand('%:p') =~# '^/tmp/dqn2html/.*\.html$'
    exe 'b ' .substitute(expand('%:p:t:r'), '%', '/', 'ge')
  elseif expand('%:p') =~# '.dqn\~\=$'
  exe 'e /tmp/dqn2html/' .expand('%:p:h:h:t') .'\%'
    \ .expand('%:p:h:t') .'\%' .expand('%:t:r') . '.html'
  endif
endfunc " }}}

" Defining commands and mappings {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Defining commands {{{2
""""""""""""""""""""""""""""""""""""""""
command -range Dqn2html <line1>,<line2>call Dqn2html(0, 1)
command -range Reloadhtml <line1>,<line2>call Dqn2html(0, 0)

" mappings {{{2
""""""""""""""""""""""""""""""""""""""""

" vimscript thingy    {{{1
let &cpo = s:save_cpo
unlet s:save_cpo
let g:loaded_dqn2html = 1

" TODO Remove unwanted sections

" vim:set sw=2 sts=2 fdm=marker:
