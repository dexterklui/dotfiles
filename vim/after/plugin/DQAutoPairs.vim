" DQAutoPairs:	    Redefine auto-pairs plugin function to make it work with
"		    Eatchar()
" Maintainer:	    DQ
" Latest Change:    4 May 2020
" Version:	    1.0

" Abort if running in vi-compatible mode or the user doesn't want us.
  if &cp || exists('g:loaded_DQAutoPairs')
    if &cp && &verbose
      echo "Not loading DQAutoPairs in compatible mode."
    elseif exists('g:loaded_DQAutoPairs')
      echo "DQAutoPairs was loaded already."
    endif
    finish
  endif

" Don't need to run this script without auto-pairs plugin.
if !exists('g:AutoPairsLoaded')
  finish
end

" Redefine AutoPairsSpace()
func! AutoPairsSpace()
  if exists('b:Eatchar')
    unlet b:Eatchar
    return ''
  endif

  if !b:autopairs_enabled
    return "\<SPACE>"
  end

  func! s:getline()
    let line = getline('.')
    let pos = col('.') - 1
    let before = strpart(line, 0, pos)
    let after = strpart(line, pos)
    let afterline = after
    if g:AutoPairsMultilineClose
      let n = line('$')
      let i = line('.')+1
      while i <= n
	let line = getline(i)
	let after = after.' '.line
	if !(line =~ '\v^\s*$')
	  break
	end
	let i = i+1
      endwhile
    end
    return [before, after, afterline]
  endf

  let [before, after, ig] = s:getline()

  for [open, close, opt] in b:AutoPairsList
    if close == ''
      continue
    end
    if before =~ '\V'.open.'\v$' && after =~ '^\V'.close
      if close =~ '\v^[''"`]$'
        return "\<SPACE>"
      else
        return "\<SPACE>\<SPACE>"."\<C-G>U\<LEFT>"
      end
    end
  endfor
  return "\<SPACE>"
endf

" vimscript thingy
  let s:save_cpo = &cpo
  set cpo&vim

" Defining commands

" mappings

" vimscript thingy
  let &cpo = s:save_cpo
  unlet s:save_cpo
  let g:loaded_DQAutoPairs = 1

" vim:set sw=2 sts=2 fdm=indent:
