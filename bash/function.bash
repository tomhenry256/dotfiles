# ----- Docker -----
# get docker name
function get_docker_name() {
    option_all=''
    if [ $# == 1 ] ; then
        option_all='-a'
    fi
    container_name=`docker ps $option_all --format "table {{.Names}}" | sed -e '1d' | fzf`
}

# entry docker
function docker_exec() {
    container_name=`docker ps --format "table {{.Names}}" | sed -e '1d' | fzf`
    # exec_type=`echo "bash\nsh" | fzf`
    docker exec -it $container_name bash
}

# exec docker stop and remove
function docker_stop_and_rm() {
    container_name=`docker ps --format "table {{.Names}}" | sed -e '1d' | fzf`
    echo $container_name is stop and remove
    docker stop $container_name && docker rm $container_name
}

# exec docker stop
function docker_stop() {
    container_name=`docker ps --format "table {{.Names}}" | sed -e '1d' | fzf`
    echo $container_name is stop
    docker stop $container_name
}

# exec docker remove
function docker_rm() {
    container_name=`docker ps -a --format "table {{.Names}}" | sed -e '1d' | fzf`
    echo $container_name is remove
    docker rm $container_name
}

# ----- Vim -----

function lvim() {
    file_and_line=$1
    line=`echo $file_and_line | awk -F ':' '{print $2}'`
    file=`echo $file_and_line | awk -F ':' '{print $1}'`
    vim $file + $line
}

function lpvim() {
    file_and_line=`pbpaste`
    line=`echo $file_and_line | awk -F ':' '{print $2}'`
    file=`echo $file_and_line | awk -F ':' '{print $1}'`
    vim $file + $line
}

function fvim() {
    vim $(fzf)
}

# ----- Git -----

function git_checkout() {
    local branches branch
    branches=$(git branch -vv) &&
    branch=$(echo "$branches" | fzf +m) &&
    git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}
