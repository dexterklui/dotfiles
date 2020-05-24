setl autoindent
setl foldmethod=marker
setl conceallevel=2
setl textwidth=78
setl wrap
setl linebreak
setl showbreak=****
setl formatoptions=cqrltn
setl formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*\\\|^\\s*[◆+‣•►➱⮱]\\s*"
setl tabstop=4
setl comments=s1:/*,mb:*,ex:*/,:///
setl nojoinspaces
setl ignorecase
setl smartcase
setl concealcursor=nc
setl nrformats=alpha,hex
setl spell
setl spellfile=~/.vim/spell/en.utf-8.add,~/.vim/spell/dqn.utf-8.add
setl colorcolumn=+1

" Define mappings that are local to .dqn buffers.
"
" Format a paragraph but skip the first line (which is used for title).
nnoremap <buffer> gqm {jjgq}
nnoremap <buffer> gqn gqqgq}
"
inoremap <buffer> <C-B>t <C-O>:TableModeToggle<CR>
inoremap <buffer> <C-B><C-T> <C-O>:TableModeToggle<CR>
inoremap <buffer> <C-J><C-J> <Esc>o<C-O>0<C-O>D<Tab>
inoremap <buffer> <C-J><C-K> ░<CR>

noremap <buffer> <leader>>> :DQNDownTitle<CR>
noremap <buffer> <leader><lt><lt> :DQNUpTitle<CR>
noremap <buffer> <leader>{{ :DQNFoldMarkerToggle<CR>

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
iabbrev <buffer> latex LaTeX

" The following function is needed for iabbrev {{s
"if !exists('*Eatchar')
  func! Eatchar(pat)
    let c = nr2char(getchar(0))
    return (c =~ a:pat) ? '' : c
  endfunc
"endif

" Customize plugin AutoPairs
    let b:autopairs_enabled = 0

let b:undo_ftplugin = "setl cole< ai< fdm< fdc< js< tw< wrap< lbr< sbr< fo< flp< ts< com< ic< scs< cocu< nf< spell< cc<"
"let b:undo_ftplugin .= "| nun <buffer> gqm| nun <buffer> gqn| iun <buffer> <C-B>t| iun <buffer> <C-B><C-T>| iun <buffer> <C-J><C-J>| iun <buffer> <C-J><C-K>| unm <buffer> <leader>>>| unm <buffer> <leader><lt><lt>| unm <buffer> <leader>{{"
"let b:undo_ftplugin .= "iunab <buffer> #L| iunab <buffer> #l| iunab <buffer> {{1| iunab <buffer> {{2| iunab <buffer> {{3| iunab <buffer> {{s| iunab <buffer> ;r| iunab <buffer> ;R| iunab <buffer> ;t| iunab <buffer> ;d| iunab <buffer> latex"

let b:did_ftplugin = 1