; vim: sw=8 ft=gitconfig fdm=marker
[alias]
        ; git commands {{{1
        br = branch
        bs = bisect
        ci = commit
        co = checkout
        dt = difftool
        di = diff
        l = log
        mg = merge
        mt = mergetool
        rb = rebase
        re = remote
        rs = reset
        rt = restore
        sh = stash
        st = status
        sw = switch
        cat = cat-file

        ; named aliases {{{1
        ; git change-commits GIT_COMMITTER_NAME "old name" "new name"
        ; git change-commits GIT_AUTHOR_NAME "old name" "new name"
        change-commits = "!f() { VAR=$1; OLD=$2; NEW=$3; shift 3; git filter-branch --env-filter \"if [[ \\\"$`echo $VAR`\\\" = '$OLD' ]]; then export $VAR='$NEW'; fi\" $@; }; f "
        count = shortlog --summary --numbered
        graph = log --all --graph --decorate
        last = log -1 HEAD
        unstage = reset HEAD --

        ; commit short aliases {{{1
        cis = commit --gpg-sign
        civ = commit --verbose
        cisv = commit --verbose --gpg-sign

        ; log short aliases {{{1
        lg = log --oneline --decorate --graph
        lga = log --oneline --decorate --graph --all
        lgg = log --decorate --graph
        lgga = log --decorate --graph --all
        lggs = log --decorate --graph --stat
        lggsa = log --decorate --graph --stat --all

