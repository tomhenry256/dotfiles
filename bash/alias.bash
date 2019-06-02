# ----- alias -----

alias ls='ls -G'
alias v='vim'
alias t='tmux'
alias e='emacs -nw'
alias ..='cd ..'
## checkoutを選択式に
alias git-checkout='git checkout  $(git branch --sort=-authordate -vv | fzf --reverse | head -n 1 | sed -e "s/^\*\s*/ /g" | sed -e "s/^[ ]*//g" | sed -e "s/[ ].*//")'
## 現在のブランチでリモートにpush
alias git-push-my-origin='git push origin $(git branch | grep "*" | sed -e "s/^\*\s*//g")'
## リモートにpush先を選択式に
alias git-push-select='git push origin $(git branch -a | fzf --reverse | head -n 1 |  sed -e "s/^\*\s*//g")'
alias git-add-p='_git_add_p'
alias git-add='_git_add'
