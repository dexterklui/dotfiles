" Vim syntax file
" Language:	generic git output
" Author:	Tim Pope <vimNOSPAM@tpope.org>
" Modified:	Dexter K. Lui <dexterklui@pm.me>
" Last Change:	2020 May 16

if exists("b:current_syntax")
  finish
endif

syn case match
syn sync minlines=50

syn include @gitDiff syntax/diff.vim

syn region gitHead start=/\%^/ end=/^$/
syn region gitHead start=/\%(^commit \x\{40\}\%(\s*(.*)\)\=$\)\@=/ end=/^$/

" For git reflog and git show ...^{tree}, avoid sync issues
syn match gitHead /^\d\{6\} \%(\w\{4} \)\=\x\{40\}\%( [0-3]\)\=\t.*/
syn match gitHead /^\x\{40\} \x\{40}\t.*/

syn region gitDiff start=/^\%(diff --git \)\@=/ end=/^\%(diff --\|$\)\@=/ contains=@gitDiff fold
syn region gitDiff start=/^\%(@@ -\)\@=/ end=/^\%(diff --\%(git\|cc\|combined\) \|$\)\@=/ contains=@gitDiff

syn region gitDiffMerge start=/^\%(diff --\%(cc\|combined\) \)\@=/ end=/^\%(diff --\|$\)\@=/ contains=@gitDiff
syn region gitDiffMerge start=/^\%(@@@@* -\)\@=/ end=/^\%(diff --\|$\)\@=/ contains=@gitDiff
syn match gitDiffAdded "^ \++.*" contained containedin=gitDiffMerge
syn match gitDiffRemoved "^ \+-.*" contained containedin=gitDiffMerge

syn match  gitKeyword /^\%(object\|type\|tag\|commit\|tree\|parent\|encoding\)\>/ contained containedin=gitHead nextgroup=gitHash,gitType skipwhite
syn match  gitKeyword /^\%(tag\>\|ref:\)/ contained containedin=gitHead nextgroup=gitReference skipwhite
syn match  gitKeyword /^Merge:/  contained containedin=gitHead nextgroup=gitHashAbbrev skipwhite
syn match  gitMode    /^\d\{6\}/ contained containedin=gitHead nextgroup=gitType,gitHash skipwhite
syn match  gitIdentityKeyword /^\%(author\|committer\|tagger\)\>/ contained containedin=gitHead nextgroup=gitIdentity skipwhite
syn match  gitIdentityHeader /^\%(Author\|Commit\|Tagger\):/ contained containedin=gitHead nextgroup=gitIdentity skipwhite
syn match  gitDateHeader /^\%(AuthorDate\|CommitDate\|Date\):/ contained containedin=gitHead nextgroup=gitDate skipwhite

syn match  gitReflogHeader /^Reflog:/ contained containedin=gitHead nextgroup=gitReflogMiddle skipwhite
syn match  gitReflogHeader /^Reflog message:/ contained containedin=gitHead skipwhite
syn match  gitReflogMiddle /\S\+@{\d\+} (/he=e-2 nextgroup=gitIdentity

syn match  gitDate      /\<\u\l\l \u\l\l \d\=\d \d\d:\d\d:\d\d \d\d\d\d [+-]\d\d\d\d/ contained
syn match  gitDate      /-\=\d\+ [+-]\d\d\d\d\>/               contained
syn match  gitDate      /\<\d\+ \l\+ ago\>/                    contained
syn match  gitType      /\<\%(tag\|commit\|tree\|blob\)\>/     contained nextgroup=gitHash skipwhite
syn match  gitStage     /\<\d\t\@=/                            contained
syn match  gitReference /\S\+\S\@!/                            contained
" Add: nextgroup.=',gitPointer'
syn match  gitHash      /\<\x\{40\}\>/                         contained nextgroup=gitIdentity,gitStage,gitHash,gitPointer skipwhite
syn match  gitHash      /^\<\x\{40\}\>/ containedin=gitHead contained nextgroup=gitHash skipwhite
syn match  gitHashAbbrev /\<\x\{4,40\}\>/           contained nextgroup=gitHashAbbrev skipwhite
syn match  gitHashAbbrev /\<\x\{4,39\}\.\.\./he=e-3 contained nextgroup=gitHashAbbrev skipwhite

syn match  gitIdentity /\S.\{-\} <[^>]*>/ contained nextgroup=gitDate skipwhite
syn region gitEmail matchgroup=gitEmailDelimiter start=/</ end=/>/ keepend oneline contained containedin=gitIdentity

syn match  gitNotesHeader /^Notes:\ze\n    /

" Add: For git log --graph --decorate
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syn region  gitLogGraph start=/^\ze[|\\/ \*]\+\&.*\*/ end=/^[|\\/ ]\+\zs$/ keepend

syn keyword gitKeyword commit contained containedin=gitLogGraph
      \ nextgroup=gitHash skipwhite
syn match   gitKeyword /^[|\\/ ]\+\zsMerge:/ contained
      \ containedin=gitLogGraph nextgroup=gitHashAbbrev skipwhite
syn match  gitIdentityHeader /^[|\\/ ]\+\zs\%(Author\|Commit\|Tagger\):/
      \ contained containedin=gitLogGraph nextgroup=gitIdentity skipwhite
syn match  gitDateHeader /^[|\\/ ]\+\zs\%(AuthorDate\|CommitDate\|Date\):/
      \ contained containedin=gitLogGraph nextgroup=gitDate skipwhite

syn region  gitPointer matchgroup=gitPunc start=/(/ end=/)$/ keepend oneline
      \ contained contains=gitCurrent,gitPunc,gitTag,gitRemote,gitBranch
" Order matters. Vim matches newer syntax def first (i.e. in reverse order)
syn match   gitBranch  /\<\w\+\>/        contained containedin=gitPointer nextgroup=gitPunc
syn match   gitRemote  &[^,/]\+/[^,/]\+& contained containedin=gitPointer nextgroup=gitPunc
syn match   gitTag     /tag:[^,]*/       contained containedin=gitPointer nextgroup=gitPunc
syn match   gitPunc    /,/               contained containedin=gitPointer
      \ nextgroup=gitTag,gitRemote,gitBranch skipwhite
syn match   gitCurrent /\<HEAD ->/       contained containedin=gitPointer
      \ nextgroup=gitBranch skipwhite
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

hi def link gitDateHeader        gitIdentityHeader
hi def link gitIdentityHeader    gitIdentityKeyword
hi def link gitIdentityKeyword   Label
hi def link gitNotesHeader       gitKeyword
hi def link gitReflogHeader      gitKeyword
hi def link gitKeyword           Keyword
hi def link gitIdentity          String
hi def link gitEmailDelimiter    Delimiter
hi def link gitEmail             Special
hi def link gitDate              Number
hi def link gitMode              Number
hi def link gitHashAbbrev        gitHash
hi def link gitHash              Identifier
hi def link gitReflogMiddle      gitReference
hi def link gitReference         Function
hi def link gitStage             gitType
hi def link gitType              Type
hi def link gitDiffAdded         diffAdded
hi def link gitDiffRemoved       diffRemoved

" Add: For git log --graph --decorate
hi def link gitLogGraph          Normal
hi def link gitRemote            Error
hi def link gitTag               gitcommitUnmergedFile
hi def link gitBranch            gitcommitSelectedFile
hi def link gitPunc              Type
hi def link gitCurrent           Question

let b:current_syntax = "git"
