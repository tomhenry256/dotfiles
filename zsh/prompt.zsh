## ----- prompt setting -----
#
#autoload -U colors; colors
## every display evaluation
#setopt prompt_subst #表示毎にPROMPTで設定されている文字列を評価する
#setopt transient_rprompt
#
#function getGitInfo() {
#    git_prompt=''
#    branch=`getCurrentBranch`
#    if [ -n "$branch" ] ; then
#        git_prompt=" $branch"
#        # git_status=`git status --short `
#        # if [ -z "$git_status" ]; then
#        #     git_prompt="$git_prompt|clean"
#        # else
#        #     git_prompt="$git_prompt|dirty"
#        # fi
#        # git_prompt="$git_prompt %{$reset_color%}"
#    fi
#    echo "$git_prompt"
#}
#
#PROMPT='[`getGitInfo` %c %{$reset_color%}]
#$ '
## PROMPT='[ %{$fg[white]%}%(?.%{$bg[green]%} OK %{$reset_color%}.%{$bg[red]%} NG %{$reset_color%}) `getGitInfo`%{$bg[blue]%} %~ %{$reset_color%} ]
## $ '
## display when pipe
#PROMPT2='%{$fg[white]%}%_> %{$reset_color%}'





# ----- prompt setting -----

autoload -U colors; colors
# every display evaluation
setopt prompt_subst #表示毎にPROMPTで設定されている文字列を評価する
setopt transient_rprompt

function getGitInfo() {
    git_prompt=''
    branch=`getCurrentBranch`
    if [ -n "$branch" ] ; then
        git_prompt="%{$bg[green]%}%{$fg[white]%} $branch"
        # git_status=`git status --short `
        # if [ -z "$git_status" ]; then
        #     git_prompt="$git_prompt|clean"
        # else
        #     git_prompt="$git_prompt|dirty"
        # fi
        git_prompt="$git_prompt %{$reset_color%}"
    fi
    echo "$git_prompt"
}

PROMPT='[`getGitInfo`%{$bg[blue]%}%{$fg[white]%} %c %{$reset_color%}]
$ '
# PROMPT='[ %{$fg[white]%}%(?.%{$bg[green]%} OK %{$reset_color%}.%{$bg[red]%} NG %{$reset_color%}) `getGitInfo`%{$bg[blue]%} %~ %{$reset_color%} ]
# $ '
# display when pipe
PROMPT2='%{$fg[white]%}%_> %{$reset_color%}'
