#!/usr/bin/env bash

set +e
set -u
cd /tmp/linno_pro
source config.cfg
file_report="/tmp/all_$(date +%s)"

dir_self="$( cd $(dirname $0);pwd )"
pushd $dir_self >/dev/null

#source $dir_self/config.cfg

set_env_docker_cmds(){
    print func
    IP_HOST=$(ip route  get 1  | head -1 | cut -d'c' -f2 | xargs)
    env_ip_host="-e IP_HOST=$IP_HOST"

    HOME_INSIDE=/root
    cmd_node='node /root/wetty/app.js -p 3000'
#& disown; 
     cmd_inside="bash -c '$cmd_node & disown; echo;echo;echo; sleep 5;  git clone https://github.com/brownman/linno_pro.git; mv /root/linno_pro/* /root;chmod 755 *.sh; ls -la /root; /root/inside.sh'"
     
    container_id='brownman/linno_pro:master'
    alias_ubuntu="alias_ubuntu"
    #$(date +%s)"
    volume_apparmor='-v /usr/lib/x86_64-linux-gnu/libapparmor.so.1.1.0:/usr/lib/x86_64-linux-gnu/libapparmor.so.1:ro'
    volume_ssh="-v $HOME/.ssh:$HOME_INSIDE/.ssh"
    
    volume_tmp="-v /tmp:/tmp"

    volume_socket='-v /var/run/docker.sock:/var/run/docker.sock'
    volume_bin='-v /usr/bin/docker:/usr/bin/docker'
    ports='-p 3001:3000'
    docker_cmd_it="docker run -it  --rm --name=$alias_ubuntu --privileged=false \
        $volume_ssh  \
        $volume_socket \
        $volume_bin \
        $volume_apparmor \
        $volume_tmp \
        $env_ip_host \
        $ports \
        $container_id  \
        bash"
        
    docker_cmd_i="docker run -i  --rm --name=$alias_ubuntu --privileged=false \
        $volume_ssh  \
        $volume_socket \
        $volume_bin \
        $volume_apparmor \
        $volume_tmp \
        $env_ip_host  \
        $ports \
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
    commander_try docker stop $alias_ubuntu 2>/dev/null
    commander_try docker rm $alias_ubuntu 2>/dev/null || (  docker rm -f $alias_ubuntu 2>/dev/null )
}

run(){
    print func
    cleanup #2>/dev/null
#trap trap_exit_outside_sh EXIT SIGINT 

    #trap trap_exit_outside_sh EXIT SIGINT; 

( commander "$docker_cmd_i" )
}

steps(){
    print func
    #local arg=${1:-}
    commander set_env_docker_cmds
    commander mkdir -p /tmp/linno_pro_tmp
    #commander "$arg"
    commander run
}



trap_exit_and_sigint_outside(){

  local res=$?
  print func $res
  subject="$LOGNAME]  outside: $( date +%H:%M:%S) ] $res"
  
  #trace some error has occured !
 commander_try "./mail_for_fix.sh brownman '$subject' $file_report"
#commander_try ./mail_for_fix.sh
return $res
}

#cmd_hold_fingers="./outside.sh run bash -c ./inside.sh"
#trap 'trap_exit1' EXIT

start(){
local cmd_hold_fingers=steps
#"bash -c ./inside.sh"
export -f trap_exit_and_sigint_outside
trap 'trap_exit_and_sigint_outside' EXIT SIGINT;
set +e

(  commander_try "$cmd_hold_fingers  &> >(tee $file_report);"  )  
}

start
popd >/dev/null
