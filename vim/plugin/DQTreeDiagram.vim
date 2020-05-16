" DQTreeDiagram:    Vim custom plugin for remapping keys to type tree diagrams easily
" Maintainer:	    DQ
" Lat Change:	    May 1 2020
" Version:	    1.1

" Abort if running in vi-compatible mode or the user doesn't want us. {{{1
if &cp || exists('g:loaded_DQTreeDiagram')
  if &cp && &verbose
    echo "Not loading DQTreeDiagram in compatible mode."
  elseif exists('g:loaded_DQTreeDiagram')
    echo "DQTreeDiagram was loaded already."
  endif
  finish
endif

" vimscript thingy	{{{1
let s:save_cpo = &cpo
set cpo&vim

" Defining functions {{{1
function DQTreeDiagramOn()
  inoremap <buffer> q ┌
  inoremap <buffer> e ┐
  inoremap <buffer> z └
  inoremap <buffer> c ┘
  inoremap <buffer> w ┬
  inoremap <buffer> x ┴
  inoremap <buffer> d ┤
  inoremap <buffer> a ├
  inoremap <buffer> v │
  inoremap <buffer> h ─
  inoremap <buffer> s ┼

  let b:tree_diagram = 1
  echo 'DQTreeDiagram mapping has been made!'
endfunction

function DQTreeDiagramOff()
  iunmap <buffer> q
  iunmap <buffer> e
  iunmap <buffer> z
  iunmap <buffer> c
  iunmap <buffer> w
  iunmap <buffer> x
  iunmap <buffer> d
  iunmap <buffer> a
  iunmap <buffer> v
  iunmap <buffer> h
  iunmap <buffer> s

  unlet! b:tree_diagram
  echo 'DQTreeDiagram mapping has been wiped!'
endfunction

function DQTreeDiagramToggle()
  if exists('b:tree_diagram')
    call DQTreeDiagramOff()
  else
    call DQTreeDiagramOn()
  endif
endfunction

" Defining commands {{{1

" mappings {{{1
nnoremap <leader>td :call DQTreeDiagramToggle()<CR>

" vimscript thingy    {{{1
let &cpo = s:save_cpo
unlet s:save_cpo
let g:loaded_DQTreeDiagram = 1

" vim:set sw=2 sts=2 fdm=marker:
