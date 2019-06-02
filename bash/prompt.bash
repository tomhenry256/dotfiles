function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}


function show_jobs {
    jobs | wc -l | tr -d ' '
}

function show_git_info {
    if git rev-parse 2> /dev/null; then
        local BR="\n"
        echo ""
        echo "[ Branch:$(parse_git_branch) Add:$(show_add) Change:$(show_change) Untrack:$(show_untrack) Delete:$(show_delete) Rename:$(show_rename) Conflict:$(show_conflict) ]";
    else
        echo "";
    fi

}

function show_untrack {
    git status -s -uall | tr -d ' ' | grep -E '^\?\?' | tr -d ' ' | wc -l | tr -d ' '
}
function show_change {
    git status -s -uall | tr -d ' ' | grep -E '^M' | tr -d ' ' | wc -l | tr -d ' '
}
function show_add {
    git status -s -uall | tr -d ' ' | grep -E '^A' | tr -d ' ' | wc -l | tr -d ' '
}
function show_delete {
    git status -s -uall | tr -d ' ' | grep -E '^D' | tr -d ' ' | wc -l | tr -d ' '
}
function show_rename {
    git status -s -uall | tr -d ' ' | grep -E '^R' | tr -d ' ' | wc -l | tr -d ' '
}
function show_conflict {
    git status -s -uall | tr -d ' ' | grep -E '^U' | tr -d ' ' | wc -l | tr -d ' '
}

# prompt setting
function show_prompt {
    # PS1='[ \[\e[1;31m\]Date:\D{%Y/%m/%d}\[\e[00m\] Time:\t \[\e[1;32m\]Jobs:$(show_jobs)\[\e[00m\] Path:\w ]\[\e[2;34m\]$(show_git_info)\[\e[00m\]\n$ ';
    PS1='[ \w ]\n$ ';
}

show_prompt
