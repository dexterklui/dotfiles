" DQNYank:	    DQN plugin for yanking a paragraph
" Maintainer:	    Dexter K. Lui <dexterklui@pm.me>
" Lat Change:	    30 Apr 2020
" Version:	    1.2

" Abort if running in vi-compatible mode or the user doesn't want us.
  if &cp || exists('g:loaded_DQNYank')
    if &cp && &verbose
      echo "Not loading DQNYank in compatible mode."
    endif
    finish
  endif

" vimscript thingy
  let s:save_cpo = &cpo
  set cpo&vim

" Defining functions
  "function DQNSmartYank() range
  "  let l:currentline = a:firstline
  "  let l:string = ''
  "  while l:currentline <= a:listline

  "    let l:string
  "  endwhile
  "endfunction

  function YankToPlusClipboard(type, ...)
    " Yank the selected string (or string within the range of a motion) into
    " the file manager clipboard.
    let l:sel_save = &selection
    let &selection = 'inclusive'

    if a:0 " Invoked from Visual mode, use gv command.
      silent exe "normal! gv\"+y"
    elseif a:type == 'line'
      silent exe "normal! '[V']\"+y"
    else
      silent exe "normal! `[v`]\"+y"
    endif
    let &selection = l:sel_save
  endfunction

  function DQTranslateDQNTitles(clipboard)
    " Remove the DQNTitle markers and add a DQNLineBreaker at the end to make
    " sure it won't be joined to the next line in the following procedures
    " Competibity: 1.32: [~{ Title1 }~]
    call setreg(a:clipboard, substitute(getreg(a:clipboard),
      \ '\%(\n\|^\)\zs\[\~{ \(.\{-}\) }\~].\{-}\ze\%(\n\|$\)', '>\1░', 'ge'))
    " Competibity: 1.32: _== Title1 == (_ is a whitespace)
    call setreg(a:clipboard, substitute(getreg(a:clipboard),
      \ '\%(\n\|^\)\zs == \(.\{-}\) ==.\{-}\ze\%(\n\|$\)', '>>\1░', 'ge'))
    " Competibity: 1.32:   > Title3 <
    call setreg(a:clipboard, substitute(getreg(a:clipboard),
      \ '\%(\n\|^\)\zs  > \(.\{-}\) <.\{-}\ze\%(\n\|$\)', '>>>\1░', 'ge'))
    " Competibity: till 1.32:    [< Title4]> /    |Title4|
    call setreg(a:clipboard, substitute(getreg(a:clipboard),
      \ '\%(\n\|^\)\zs\(\t*\) \{3}|\(.\{-}\)|.\{-}\ze\%(\n\|$\)', '>>>>\1\2░', 'ge'))
    call setreg(a:clipboard, substitute(getreg(a:clipboard),
      \ '>>>>>*\zs\t\ze.*░',  '>', 'ge'))
  endfunction

  function DQAddLineBreak(clipboard)
    " Add line break at designated area to prevent it from joining the
    " following lines later
    call setreg(a:clipboard, substitute(getreg(a:clipboard),
      \  '\ze\n/\*-\{66,74}\*/\n'    . '\|'
      \ .'\n/\*-\{66,74}\*/\zs\ze\n' . '\|'
      \ .'\ze\n-\{70,78}\n'          . '\|'
      \ .'\n-\{70,78}\zs\ze\n'       . '\|'
      \ .'\ze\n=\{70,78}\n'          . '\|'
      \ .'\n=\{70,78}\zs\ze\n'
      \ , '░', 'ge'))
  endfunction

  function DQJoinBrokenLines(clipboard)
    " Join broken lines within a paragraph (except bullet points or lists, and
    " except when the previous line ends in :, ░, or a separator)
    call setreg(a:clipboard, substitute(getreg(a:clipboard),
      \ '\%('
      \   .'\n'            . '\|'
      \   .':'             . '\|'
      \   .'░'
      \   . '\)\@10<!'
      \ .'\zs\n'
      \   . '\%('
      \     . '\s*\%('
      \       . '\%((\=\d\+)\)' . '\|'
      \       . '\%(\d\+\.\)'   . '\|'
      \       . '➱'             . '\|'
      \       . '⮱'             . '\|'
      \       . '‣'             . '\|'
      \       . '+'             . '\|'
      \       . '*'             . '\|'
      \       . '·'             . '\|'
      \       . '\n'
      \       . '\)'
      \     . '\)\@10!' . '\s*'
      \ , ' ', 'ge'))
  endfunction

  function DQRemoveEmptyLines(clipboard)
    call setreg(a:clipboard, substitute(getreg(a:clipboard), '\n\ze\n', '', 'ge'))
    call setreg(a:clipboard, substitute(getreg(a:clipboard), '\%^\n', '', 'ge'))
  endfunction

  function DQIndentReduce(clipboard)
    "Take the string in the file manager clipboard, reduce one level of
    "indentation.
    call setreg(a:clipboard, substitute(getreg(a:clipboard), '\%^\t*\zs\t\ze\S', '', 'ge'))
    call setreg(a:clipboard, substitute(getreg(a:clipboard), '\n\t*\zs\t\ze\S', '', 'ge'))
  endfunction

  function DQRemoveTrailingWhitespaces(clipboard)
    call setreg(a:clipboard, substitute(getreg(a:clipboard), '\s*\ze\n', '', 'ge'))
    call setreg(a:clipboard, substitute(getreg(a:clipboard), '\s*\ze\%$', '', 'ge'))
  endfunction

  function DQRemoveFoldMarkers(clipboard)
    call setreg(a:clipboard, substitute(getreg(a:clipboard), '{{{\d*', '', 'ge'))
  endfunction

  function DQRemoveDQNMarkers(clipboard)
    " Take the string in the file manager clipboard, remove any DQN
    " highlighting markers, and vim folding markers.
    call setreg(a:clipboard, substitute(getreg(a:clipboard), 
      \  '\[\[\(\_.\{-}\)]]'            . '\|'
      \ .'\[{\(\_.\{-}\)]}'             . '\|'
      \ .'\['."'".'\(\_.\{-}\)]'."'"    . '\|'
      \ .'\[-\(\_.\{-}\)]-'             . '\|'
      \ .'\[=\(\_.\{-}\)]='             . '\|'
      \ .'\["\(\_.\{-}\)]"'             . '\|'
      \ .'\[;\(\_.\{-}\)];'             . '\|'
      \ .'\[/\(\_.\{-}\)]/'             . '\|'
      \ .'\[,\(\_.\{-}\)],'
      \ , '\1\2\3\4\5\6\7\8\9', 'ge'))

    call setreg(a:clipboard, substitute(getreg(a:clipboard), 
      \  '\[_\(\_.\{-}\)]_'             . '\|'
      \ .'\[\\\(\_.\{-}\)]\\'           . '\|'
      \ .'\[|\(\_.\{-}\)]|'
      \ , '\1\2\3', 'ge'))

    " For the following DQN marker, its content will also be completely wiped out.
    call setreg(a:clipboard, substitute(getreg(a:clipboard),
      \ '\[\.\_.\{-}]\.', '', 'ge'))

    " Remove dqnNomatch which prevents match dqn syntax
    call setreg(a:clipboard, substitute(getreg(a:clipboard), 
      \ '\[\zs\~\ze[[{' ."'". '-=";/,_\\|.]'
      \ , '', 'ge'))
    call setreg(a:clipboard, substitute(getreg(a:clipboard), 
      \ ']\zs\~\ze[]}' ."'". '-=";/,_\\|.]'
      \ , '', 'ge'))
    " XXX
    call setreg(a:clipboard, substitute(getreg(a:clipboard), 
      \ '\%(\[\[\|]]\)\zs\~\ze'
      \ , '', 'ge'))

    call setreg(a:clipboard, substitute(getreg(a:clipboard), 
      \  '`\[\(\_.\{-}\)`]'            . '\|'
      \ .'`{\(\_.\{-}\)`}'             . '\|'
      \ .'`'."'".'\(\_.\{-}\)`'."'"    . '\|'
      \ .'`-\(\_.\{-}\)`-'             . '\|'
      \ .'`=\(\_.\{-}\)`='             . '\|'
      \ .'`"\(\_.\{-}\)`"'             . '\|'
      \ .'`;\(\_.\{-}\)`;'             . '\|'
      \ .'`/\(\_.\{-}\)`/'             . '\|'
      \ .'`,\(\_.\{-}\)`,'
      \ , '\1\2\3\4\5\6\7\8\9', 'ge'))

    call setreg(a:clipboard, substitute(getreg(a:clipboard), 
      \  '`_\(\_.\{-}\)`_'             . '\|'
      \ .'`\\\(\_.\{-}\)`\\'           . '\|'
      \ , '\1\2', 'ge'))

    " Remove dqnNomatch which prevents match dqn syntax
    call setreg(a:clipboard, substitute(getreg(a:clipboard), 
      \ '`\zs\~\ze[][}{' ."'". '-=";/,_\\.]'
      \ , '', 'ge'))
  endfunction

  function DQRemoveDQNLineBreaker(clipboard)
    call setreg(a:clipboard, substitute(getreg(a:clipboard), '░\ze\n', '', 'ge'))
    call setreg(a:clipboard, substitute(getreg(a:clipboard), '░\ze\%$', '', 'ge'))
  endfunction

  function DQNYank(type, ...)
    " Yanking into Filemanager clipboard, then pass both the
    " DQNYankParapgraphFilter and DQNhighlightFilter.
    if a:0
      call YankToPlusClipboard(a:type, 1)
    else
      call YankToPlusClipboard(a:type)
    endif
    call DQTranslateDQNTitles('+')
    call DQAddLineBreak('+')
    call DQJoinBrokenLines('+')
    call DQRemoveEmptyLines('+')
    call DQIndentReduce('+')
    call DQRemoveTrailingWhitespaces('+')
    call DQRemoveFoldMarkers('+')
    call DQRemoveDQNMarkers('+')
    call DQRemoveDQNLineBreaker('+')
    call DQRemoveTrailingWhitespaces('+')
  endfunction

  "function! Osc52Yank()
  "  let buffer=system('base64 -w0', @0) " -w0 to disable 76 char line wrapping
  "  let buffer='\ePtmux;\e\e]52;c;'.buffer.'\x07\e\\'
  "  silent exe "!echo -ne ".shellescape(buffer)." > ".shellescape('tty2')
  "  redraw
  "endfunction

" Defining commands

" mappings
  nnoremap <silent> Y :set opfunc=YankToPlusClipboard<CR>g@
  vnoremap <silent> Y :<C-U>call YankToPlusClipboard(visualmode(), 1)<CR>
  nnoremap <silent> Yy :set opfunc=DQNYank<CR>g@
  vnoremap <silent> Yy :<C-U>call DQNYank(visualmode(), 1)<CR>
  nnoremap <silent> YY "+yy
  nnoremap <silent> yc ^y$
  nnoremap <silent> Yc ^"+y$
  "nnoremap YT :call Osc52Yank()<CR>

" vimscript thingy
  let &cpo = s:save_cpo
  unlet s:save_cpo
  let g:loaded_DQNYank = 1

" vim:set sw=2 sts=2 fdm=indent:
