" SuperSubscripts:  Vim plugin for defining alphabetical super/subscripts
"                   digraphs
" Maintainer:       Dexter K. Lui <dexterklui@pm.me>
" Latest Change:    15 Sep 2022
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vimscript thingy {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Abort if running in vi-compatible mode or the user doesn't want us. {{{2
""""""""""""""""""""""""""""""""""""""""
if &cp || exists('g:loaded_DQSuperSubscripts')
  if &cp && &verbose
    echo "Not loading DQSuperSubscripts in compatible mode."
  endif
  finish
endif

" vimscript thingy {{{2
""""""""""""""""""""""""""""""""""""""""
let s:save_cpo = &cpo
set cpo&vim

" Defining digraphs {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" lower case alphabet subscripts {{{2
"""""""""""""""""""""""""""""""""""
execute "digraphs _a " . 0x2090
execute "digraphs _e " . 0x2091
execute "digraphs _h " . 0x2095
execute "digraphs _i " . 0x1D62
execute "digraphs _j " . 0x2C7C
execute "digraphs _k " . 0x2096
execute "digraphs _l " . 0x2097
execute "digraphs _m " . 0x2098
execute "digraphs _n " . 0x2099
execute "digraphs _o " . 0x2092
execute "digraphs _p " . 0x209A
execute "digraphs _r " . 0x1D63
execute "digraphs _s " . 0x209B
execute "digraphs _t " . 0x209C
execute "digraphs _u " . 0x1D64
execute "digraphs _v " . 0x1D65
execute "digraphs _x " . 0x2093

" lower case alphabet superscripts {{{2
"""""""""""""""""""""""""""""""""""
execute "digraphs `a " . 0x1d43
execute "digraphs `b " . 0x1d47
execute "digraphs `c " . 0x1d9c
execute "digraphs `d " . 0x1d48
execute "digraphs `e " . 0x1d49
execute "digraphs `f " . 0x1da0
execute "digraphs `g " . 0x1d4d
execute "digraphs `h " . 0x02b0
execute "digraphs `i " . 0x2071
execute "digraphs `j " . 0x02b2
execute "digraphs `k " . 0x1d4f
execute "digraphs `l " . 0x02e1
execute "digraphs `m " . 0x1d50
execute "digraphs `n " . 0x207f
execute "digraphs `o " . 0x1d52
execute "digraphs `p " . 0x1d56
execute "digraphs `r " . 0x02b3
execute "digraphs `s " . 0x02e2
execute "digraphs `t " . 0x1d57
execute "digraphs `u " . 0x1d58
execute "digraphs `v " . 0x1d5b
execute "digraphs `w " . 0x02b7
execute "digraphs `x " . 0x02e3
execute "digraphs `y " . 0x02b8
execute "digraphs `z " . 0x1dbb

" uppercase case alphabet superscripts {{{2
"""""""""""""""""""""""""""""""""""
execute "digraphs `A " . 0x1D2C
execute "digraphs `B " . 0x1D2E
execute "digraphs `D " . 0x1D30
execute "digraphs `E " . 0x1D31
execute "digraphs `G " . 0x1D33
execute "digraphs `H " . 0x1D34
execute "digraphs `I " . 0x1D35
execute "digraphs `J " . 0x1D36
execute "digraphs `K " . 0x1D37
execute "digraphs `L " . 0x1D38
execute "digraphs `M " . 0x1D39
execute "digraphs `N " . 0x1D3A
execute "digraphs `O " . 0x1D3C
execute "digraphs `P " . 0x1D3E
execute "digraphs `R " . 0x1D3F
execute "digraphs `T " . 0x1D40
execute "digraphs `U " . 0x1D41
execute "digraphs `V " . 0x2C7D
execute "digraphs `W " . 0x1D42

" vimscript thingy {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let &cpo = s:save_cpo
unlet s:save_cpo
let g:loaded_DQSuperSubscripts = 1

" vim:set sw=2 sts=2 fdm=marker:
