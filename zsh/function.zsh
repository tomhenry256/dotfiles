# ----- Git -----

function git-checkout() {
    `git checkout  $(git branch --sort=-authordate -vv | fzf --reverse | head -n 1 | sed -e "s/^\*\s*/ /g" | sed -e "s/^[ ]*//g" | sed -e "s/[ ].*//")`
}

function git-add-p(){
    files=$(git status -s | grep -v \? |  grep -E "^.M" | perl -pe "s/(?<=^.{0}).{3}//g" | fzf --reverse )
    wc=`echo $files | wc -l`
    if [ $wc -ne 1 ]; then
        files=$(echo $files | sed -e :loop -e 'N; $!b loop' -e 's/\n/ /g')
    fi
    if [ -n "$files" ]; then
        git add -p ${=files}
    fi
}

# echo current branch
function getCurrentBranch() {
    echo | git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

# ----- Etc -----

source_fzf() {
    file=`echo ".zshrc\n.bashrc" | fzf`
    if [ -n "~/$file" ] ; then
        echo "source $file\n"
        source ~/$file
    fi
}

# fgを使わずctrl+zで行ったり来たりする
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# fgをpecoで
alias fgg='_fgg'
function _fgg() {
    wc=$(jobs | wc -l | tr -d ' ')
    if [ $wc -ne 0 ]; then
        job=$(jobs | awk -F "suspended" "{print $1 $2}"|sed -e "s/\-//g" -e "s/\+//g" -e "s/\[//g" -e "s/\]//g" | grep -v pwd | fzf --reverse | awk "{print $1}")
        wc_grep=$(echo $job|grep -v grep | grep 'suspended')
        if [ "$wc_grep" != "" ]; then
            fg %$job
        fi
    else
        echo "fgg: no current jobs."
    fi
}
zle -N _fgg
bindkey '^k^l' _fgg
