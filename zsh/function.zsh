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

alias git-log-copy='_git_log_copy'
function _git_log_copy() {
    # git log --oneline --pretty=format:'[%cd]  %h  %s' --date=format:'%Y/%m/%d %H:%M:%S' | peco --prompt "LOG" | head -n 1 | perl -pe "s/(?<=^.{0}).{22}//g" | pbcopy
    git log --oneline --pretty=format:'[%cd]  %h  %s' --date=format:'%Y/%m/%d %H:%M:%S' | fzf --reverse | head -n 1 | perl -pe "s/(?<=^.{0}).{22}//g" | pbcopy
}

alias git-log-show='_git_log_show'
function _git_log_show() {
    # git log --oneline --pretty=format:'[%cd]  %h  %s' --date=format:'%Y/%m/%d %H:%M:%S' | peco --prompt "LOG" | head -n 1 | perl -pe "s/(?<=^.{0}).{22}//g" | pbcopy
    COMMIT_NUMBER=`git log --oneline --pretty=format:'[%cd]  %h  %s' --date=format:'%Y/%m/%d %H:%M:%S' | fzf --reverse | head -n 1 | perl -pe "s/(?<=^.{0}).{23}//g" | cut -c 1-10`
    git show -p ${COMMIT_NUMBER}
}


function lvim() {
    file_and_line=$1
    line=`echo $file_and_line | awk -F ':' '{print $2}'`
    file=`echo $file_and_line | awk -F ':' '{print $1}'`
    vim $file +$line
}

function lpvim() {
    file_and_line=`pbpaste`
    line=`echo $file_and_line | awk -F ':' '{print $2}'`
    file=`echo $file_and_line | awk -F ':' '{print $1}'`
    vim $file +$line
}

function fvim() {
    vim $(fzf)
}



function docker_exec() {
    container_name=`docker ps --format "table {{.Names}}" | sed -e '1d' | fzf` ; docker exec -it $container_name bash
}

function docker_stop() {
    container_name=$1
    if [ "$container_name" = "" ] ; then
        container_name=`docker ps --format "table {{.Names}}" | sed -e '1d' | fzf`
    fi
    docker stop $container_name
}

function docker_rm() {
    container_name=$1
    if [ "$container_name" = "" ] ; then
        container_name=`docker ps -a --format "table {{.Names}}" | sed -e '1d' | fzf`
    fi
    docker rm $container_name
}
