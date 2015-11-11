#!/usr/bin/env bash

clear
unset trace
unset commander
unset cleanup
unset steps

trace(){
    echo 1>&2 $*
}

commander(){
    local args=( $@ )
    local cmd="${args[@]}"
    trace [cmd] $cmd
    eval "$cmd" || { trace got error; exit 1; }
}



set_env(){
    cmd_inside="${cmd_inside:-'bash -c ./inside.sh'}"
    container_id='brownman/linno_pro:master'
    alias_ubuntu=alias_ubuntu
    volume_apparmor='-v /usr/lib/x86_64-linux-gnu/libapparmor.so.1.1.0:/usr/lib/x86_64-linux-gnu/libapparmor.so.1:ro'
    volume_ssh="-v $HOME/.ssh:/root/.ssh"
    volume_socket='-v /var/run/docker.sock:/var/run/docker.sock'
    volume_bin='-v /usr/bin/docker:/usr/bin/docker'
}

build(){
    ( docker images | egrep -h $container_id  )
    local res=$1
    local answer

    trace re-build dockerfile ?
    read answer
    if [ "$answer" = y ];then
        commander docker build -t $container_id  .
    else
        trace skip building image
    fi
}

cleanup(){
    ( docker ps | grep alias_ubuntu 2>/dev/null )  && { \
        docker stop $alias_ubuntu 2>/dev/null
    docker rm $alias_ubuntu 2>/dev/null
}
}

run(){
    cleanup #2>/dev/null

    commander docker run -i --rm --name=$alias_ubuntu --privileged=true \
        $volume_ssh  \
        $volume_socket \
        $volume_bin \
        $volume_apparmor \
        $container_id  \
        $cmd_inside
}

steps(){
    local arg=${1:-}
    set_env
    commander "$arg"
}


echo --- hi ---
( test $# -eq 0  )  &&  { \
    trace 1st argument: build OR run
exit 1;
} || { \

    if [[ $1 = build || $1 = run ]];then
        func1=$1
        cmd_inside="${@:2}"
        commander steps $func1 $args
    else
        trace 1st argument: build OR run
    fi
}
echo --- bye ---
