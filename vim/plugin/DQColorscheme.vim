" DQColorscheme:    Plugin for changing colorscheme
" Maintainer:	    Dexter K. Lui <dexterklui@pm.me>
" Lat Change:	    11 May 2020
" Version:	    1.2

" Abort if running in vi-compatible mode or the user doesn't want us.
  if &cp || exists('g:loaded_DQColorscheme')
    if &cp && &verbose
      echo "Not loading DQColorscheme in compatible mode."
    elseif exists('g:loaded_DQColorscheme')
      echo "DQColorscheme was loaded already."
    endif
    finish
  endif

" vimscript thingy
  let s:save_cpo = &cpo
  set cpo&vim

" Defining functions
  function DQPlColorMatch()
    " Match the colorscheme of the Powerline to that of Vim.
    " Check if config.json exists.
    let l:fname = expand('~/.config/powerline/config.json')
    let l:fnpattern = substitute(l:fname, '\(\~\|\[\|\.\|\*\)', '\\\1', 'g')
    if filewritable(l:fname) != 1
      echoe l:fname . ' does not exist or is not writable! Colorscheme of powerline did not change.'
      return
    endif

    " Add config.json to the buffer if it wasn't there yet
    if !bufexists(l:fname)
      let l:del = 1
      exe 'badd ' . l:fname
    endif

    let l:bufnr = bufnr('^' . l:fnpattern . '$')

    " Toggle the colorscheme of Powerline.
    exe l:bufnr . 'sbuffer'
    if !buflisted(l:bufnr)
      set buflisted " this is required for :bufdo cmd
      let l:del = 1
    endif
    if g:colors_name =~# '^dqsolarized$\|^solarized$'
      exe l:bufnr . 'bufdo %s/^\s*"vim":.*\n\s*"colorscheme": \="\zsdefault\ze"/solarized/e| update'
    else
      exe l:bufnr . 'bufdo %s/^\s*"vim":.*\n\s*"colorscheme": \="\zssolarized\ze"/default/e| update'
    endif
    close

    " Delete config.json from buffer list if it was added/relisted to the buffer by the function.
    if exists('l:del')
      exe 'bdelete ' . l:bufnr
    endif
  endfunction

  function DQAlColorMatch()
    " Match the colorscheme of the Airline to that of Vim.
    if g:colors_name ==# 'dqsolarized'
      AirlineTheme dqsolarized
    elseif g:colors_name ==# 'solarized'
      AirlineTheme solarized
    else
      AirlineTheme dark
    endif
  endfunction

  function DQColorToggle()
    " Toggle colorscheme between (dq)solarized or dd/default.
    if g:colors_name !~ '^dqsolarized$\|^solarized$'
      try
	colorscheme dqsolarized
      catch /^Vim\%((\a\+)\)\=:E185/
	colorscheme solarized
      catch /^Vim\%((\a\+)\)\=:E185/
	colorscheme dd
      catch /^Vim\%((\a\+)\)\=:E185/
	colorscheme default
      endtry
    elseif g:colors_name !~ '^dd$\|^default$'
      try
	colorscheme dd
      catch /^Vim\%((\a\+)\)\=:E185/
	colorscheme default
      endtry
    endif

    if exists('g:loaded_powerline')
      call DQPlColorMatch()
    endif

    if exists('g:loaded_airline')
      call DQAlColorMatch()
    endif

    echo 'New colorscheme: ' . g:colors_name
  endfunction

  function DQDarkCommentToggle()
    " Toggle concealment for comment
    if exists('g:dqsolarized_dark_comment') && g:dqsolarized_dark_comment == 1
      let g:dqsolarized_dark_comment = 0
      colorscheme dqsolarized
    else
      let g:dqsolarized_dark_comment = 1
      colorscheme dqsolarized
    endif
  endfunction


" mappings
  nnoremap <Leader>cs :call DQColorToggle()<CR>
  nnoremap <Leader>C :call DQDarkCommentToggle()<CR>

" vimscript thingy
  let &cpo = s:save_cpo
  unlet s:save_cpo
  let g:loaded_DQColorscheme = 1

" vim:set sw=2 sts=2 fdm=indent:
