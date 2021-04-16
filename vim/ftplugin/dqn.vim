" Ftplugin:      Filetype plugin for DQN
" Maintainer:    Dexter K. Lui <dexterklui@pm.me>
" Latest Change: 8 Jun 2020
" Version:       1.34.3 (DQN v1.34)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

setl autoindent
setl foldmethod=marker
setl conceallevel=2
setl textwidth=78
setl wrap
setl linebreak
setl formatoptions=cqltn
setl formatlistpat=^\\s*(\\=\\d\\+[:.)]\\s\\+\\\|^\\s*[⮱➱‣•·+*-]\\s\\+
setl tabstop=4
setl comments=:///
setl nojoinspaces
setl ignorecase
setl smartcase
setl concealcursor=nc
setl nrformats=alpha,hex
setl spell
setl spellfile+=~/.config/nvim/spell/dqn.utf-8.add
setl colorcolumn=+1
setl breakindent
setl breakindentopt=min:32,shift:-1
setl nolist
setl virtualedit=block

" Define mappings that are local to .dqn buffers.
"
" Format a paragraph but skip the first line (which is used for title).
nnoremap <buffer> gqn m`gq}``
nnoremap <buffer> <Leader>fi :call <SID>openImg()<CR>

inoremap <buffer> <C-B>t <C-O>:TableModeToggle<CR>
inoremap <buffer> <C-B><C-T> <C-O>:TableModeToggle<CR>
inoremap <buffer> <C-J><C-J> <Esc>o<C-O>0<C-O>D<Tab>
inoremap <buffer> <C-J><C-K> ░<CR>

" Define abbreviations that are local to .dqn buffers.
iabbrev <buffer> #l ----------------------------------------------------------------------
iabbrev <buffer> #L ======================================================================

iabbrev <buffer> {{1 <C-O>0<C-O>d$[~{<Space>}~]<Space>{{{1<Left><Left><Left><Left><Left><Left><Left><Left><Left>
"iabbrev <buffer> }}1 -<Space>]<Space>{{{1
iabbrev <buffer> {{2 <C-O>0<C-O>d$ ==<Space>==<Space>{{{2<Left><Left><Left><Left><Left><Left><Left><Left>
iabbrev <buffer> {{3 <C-O>0<C-O>d$<Space><Space>><Space><<Space>{{{3<Left><Left><Left><Left><Left><Left><Left>
" The 2nd line in the following iabbrev because of auto-pairs plugin. To make
" it work, I modified the plugin by redefining its function AutoPairsSpace().
iabbrev <buffer> {{s <C-O>0<C-O>d$<Space><Space><Space><Bar><Bar><Left>
  \<C-O>:let b:Eatchar=1<CR>
  \<C-R>=Eatchar('\s')<CR>
iabbrev <buffer> {{S <C-O>0<C-O>d$<Space><Space><Space><Bar><Bar><Space>{{{4<Left><Left><Left><Left><Left><Left>
  \<C-O>:let b:Eatchar=1<CR>
  \<C-R>=Eatchar('\s')<CR>
iabbrev <buffer> ;r ➱
iabbrev <buffer> ;R ⮱
iabbrev <buffer> ;t ‣
iabbrev <buffer> ;d ·
iabbrev <buffer> ;D •
iabbrev <buffer> latex LaTeX
iabbrev <buffer> ;; <BS><Space>

" Mappings for dqn plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DQToggleConceal
""""""""""""""""""""""""""""""""""""""""
nnoremap <buffer> <leader>cl :call DQToggleConceal()<CR>
nnoremap <buffer> <leader>cn :call DQToggleNormalCocu()<CR>
" DQNote
""""""""""""""""""""""""""""""""""""""""
noremap <buffer> <leader>>> :DQNDownTitle<CR>
noremap <buffer> <leader><lt><lt> :DQNUpTitle<CR>
noremap <buffer> <leader>{{ :DQNFoldMarkerToggle<CR>
nnoremap <buffer> gqm :call DqnParFormat()<CR>
" Dqn2html
""""""""""""""""""""""""""""""""""""""""
nnoremap <buffer> <F12> :Dqn2html<CR>

" The following function is needed for iabbrev {{s
"if !exists('*Eatchar')
  func! Eatchar(pat)
    let c = nr2char(getchar(0))
    return (c =~ a:pat) ? '' : c
  endfunc
"endif

" Customize plugin AutoPairs
let b:autopairs_enabled = 0

let b:undo_ftplugin = "setl cole< ai< fdm< fdc< js< tw< wrap< lbr< fo< flp< ts<"
      \ . " com< ic< scs< cocu< nf< spell< cc< bri< briopt< list< ve<"
let b:undo_ftplugin .= "| nun <buffer> gqn| nun <buffer> <leader>fi"
      \ . "| iun <buffer> <C-B>t| iun <buffer> <C-B><C-T>"
      \ . "| iun <buffer> <C-J><C-J>| iun <buffer> <C-J><C-K>"
let b:undo_ftplugin .= "| iunab <buffer> #L| iunab <buffer> #l"
      \ . "| iunab <buffer> {{1| iunab <buffer> {{2| iunab <buffer> {{3"
      \ . "| iunab <buffer> {{s| iunab <buffer> ;r| iunab <buffer> ;R"
      \ . "| iunab <buffer> ;t| iunab <buffer> ;d| iunab <buffer> ;D"
      \ . "| iunab <buffer> latex"
" DQN Plugins
""""""""""""""""""""""""""""""""""""""""
let b:undo_ftplugin .= "| nun <buffer> <leader>cl| nun <buffer> <leader>cn"
let b:undo_ftplugin .= "| nun <buffer> gqm| unm <buffer> <leader>>>"
      \ . "| unm <buffer> <leader><lt><lt>| unm <buffer> <leader>{{"
let b:undo_ftplugin .= "|nun <buffer> <F12>"

let b:did_ftplugin = 1
