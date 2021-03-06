" DQVim:            Vim plugin for Vim files
" Maintainer:       Dexter K. Lui <dexterklui@pm.me>
" Latest Change:    3 June 2020
" Version:          1.4

" Abort if running in vi-compatible mode or the user doesn't want us.
  if &cp || exists('g:loaded_DQVim')
    if &cp && &verbose
      echo "Not loading DQVim in compatible mode."
    endif
    finish
  endif

" vimscript thingy
  let s:save_cpo = &cpo
  set cpo&vim

" Functions
  function ResourceScpt()
    " Write if needed and resource the current vim script
    if expand('%:e') !=# 'vim' && expand('%:t') !~# '^\.\=vimrc$'
      echoe 'This is not a vim script (.vim)! aborting function.'
    endif

    update " Write if changed
    let l:line = line('.') " record cursor position
    let l:col = col('.')

    try " Add '!' to force func/cmd definition
      %s/^\s*\zs\(fun\=c\=t\=i\=o\=n\=\)\ze\s\+\w\|^\s*\zs\(comm\=a\=n\=d\=\)\ze\s\+[A-Z-]/\1\2!/
      write
    catch /^Vim\%((\a\+)\)\=:E486/
      let l:unchanged = 1
    endtry

    " Unlet the variable indicating that this Vim script is loaded
    exe 'unlet! g:loaded_'.substitute(expand('%:t:r'), '^\.', '', 'e')

    source % " source this file

    if !exists('l:unchanged') " Remove added '!', if any
      earlier 1f
      write
    endif

    call cursor(l:line, l:col) " restore the cursor position
  endfunction

  function VimRunSel() range
    " Run as Vim Ex cmd using the range of visual selection
    let l:reg = getreg('*')
    exe a:firstline .',' .a:lastline .'yank *'
    call setreg('*', substitute(getreg('*'), '\n\s*\\\(/\|&\|?\)\@!', '', 'ge'))
    @*
    call setreg('*', l:reg)
  endfunction

  function ArgAdd() range
    " Add filename to arg list for each line in range
    for m in range(a:firstline, a:lastline)
      exe '$argadd ' . getline(m)
    endfor
  endfunction

  function VimDiffSrc()
    " Runs vim diff between that in ~/.vim and ~/src/dotfiles
    if expand('%:p:~') =~# '^\~/src/dotfiles/vim/'
      if filereadable(expand('~') . '/.vim/' . substitute(expand('%:p:~'), '^\~/src/dotfiles/vim/', '', ''))
        exe 'diffsplit ' . expand('~') . '/.vim/' . substitute(expand('%:p:~'), '^\~/src/dotfiles/vim/', '', '')
      elseif filereadable(expand('~') . '/.config/nvim/' . substitute(expand('%:p:~'), '^\~/src/dotfiles/vim/', '', ''))
        exe 'diffsplit ' . expand('~') . '/.config/nvim/' . substitute(expand('%:p:~'), '^\~/src/dotfiles/vim/', '', '')
      else
        echom 'Cannot find a corresponding file in ~/.vim/ or ~/.config/nvim/.'
      endif
    else
      if expand('%:p:~') =~# '^\~/.vim/\|^\~/.config/nvim/'
        exe 'diffsplit ' . expand("~") . "/src/dotfiles/vim/" . substitute(expand('%:p:~'), '^\~/.vim/\|^\~/.config/nvim/', '', '')
      else
        echom 'Cannot find a corresponding file in ~/src/dotfiles/vim/.'
      endif
    endif
  endfunction

" Defining commands
  command Sovim call ResourceScpt()
  command -range Runvim <line1>,<line2>call VimRunSel()

" mappings

" vimscript thingy
  let &cpo = s:save_cpo
  unlet s:save_cpo
  let g:loaded_DQVim = 1

" vim:set sw=2 sts=2 fdm=indent:
