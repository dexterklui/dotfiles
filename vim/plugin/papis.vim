" papis:            Vim integration of Papis
" Maintainer:       Dexter K. Lui <dexterklui@pm.me>
" Latest Change:    3 Jan 2023
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vimscript thingy {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Abort if running in vi-compatible mode or the user doesn't want us. {{{2
""""""""""""""""""""""""""""""""""""""""
if &cp || exists('g:loaded_papis')
  if &cp && &verbose
    echo "Not loading papis in compatible mode."
  endif
  finish
endif

" vimscript thingy {{{2
""""""""""""""""""""""""""""""""""""""""
let s:save_cpo = &cpo
set cpo&vim

" Defining functions {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
func PapisBibtexRef()
  let l:temp = tempname()
  echom l:temp
  if has('nvim')
    silent exec "terminal papis bibtex read ". expand("%:r") .".bib ref -o ".l:temp
    startinsert
    let @9 = l:temp " Save the stored citation key into the temp file in reg 9
    " Need manually run :read <temp_file>
  else
    silent exec "!papis bibtex read ". expand("%:r") .".bib ref -o ".l:temp
    let l:olda = @a
    let @a = join(readfile(l:temp), ',')
    normal! "ap
    redraw!
    let @a = l:olda
  endif
endfunc

" Defining commands and mappings {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command -nargs=0 BibRef call PapisBibtexRef()
command -nargs=0 BibOpen exec "!papis bibtex read " . expand("%:r") . ".bib open"

" vimscript thingy {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let &cpo = s:save_cpo
unlet s:save_cpo
let g:loaded_papis = 1

" vim:set sw=2 sts=2 fdm=marker:
