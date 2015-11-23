#!/usr/bin/env bash
dir_self="$( cd $(dirname $0);pwd )"
pushd $dir_self >/dev/null
clear
source $dir_self/config.cfg

set_env(){
    HOME_INSIDE=/root
 cmd_inside="bash -c 'git clone https://github.com/brownman/linno_pro.git; mv ./linno_pro/* .;chmod 755 *.sh; ls -la /root; ./report_dev_inside.sh'"
    container_id='brownman/linno_pro:master'
   export alias_ubuntu=alias_ubuntu1
    volume_apparmor='-v /usr/lib/x86_64-linux-gnu/libapparmor.so.1.1.0:/usr/lib/x86_64-linux-gnu/libapparmor.so.1:ro'
    volume_ssh="-v $HOME/.ssh:$HOME_INSIDE/.ssh"
    
    volume_tmp="-v /tmp:/tmp"

    volume_socket='-v /var/run/docker.sock:/var/run/docker.sock'
    volume_bin='-v /usr/bin/docker:/usr/bin/docker'
    docker_cmd_it="docker run -it  --rm --name=$alias_ubuntu --privileged=true \
        $volume_ssh  \
        $volume_socket \
        $volume_bin \
        $volume_apparmor \
        $volume_tmp \
        $container_id  \
        bash"
        
    docker_cmd_i="docker run -i  --rm --name=$alias_ubuntu --privileged=true \
        $volume_ssh  \
        $volume_socket \
        $volume_bin \
        $volume_apparmor \
        $volume_tmp \
        $container_id  \
        $cmd_inside"
}

build(){
    print func
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
    print func
         docker stop $alias_ubuntu 2>/dev/null
    docker rm $alias_ubuntu 2>/dev/null || (  docker rm -f $alias_ubuntu 2>/dev/null )


}

run(){
    print func
    cleanup #2>/dev/null
#trap trap_exit_outside_sh EXIT SIGINT 

( 
    trap trap_exit_outside_sh EXIT SIGINT; 
    commander "$docker_cmd_i" )
}

steps(){
    print func
    local arg=${1:-}
    set_env
    mkdir -p /tmp/linno_pro_tmp
    commander "$arg"
}



trap_exit_outside_sh(){
    local res=$?
    print func
    cleanup
    print warning try to run: 
trace $docker_cmd_it
return $res
}

export -f trap_exit_outside_sh



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
popd >/dev/null
