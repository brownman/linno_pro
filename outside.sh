#!/usr/bin/env bash

set +e
set -u
cd /tmp/linno_pro
source config.cfg
file_report="/tmp/all_$(date +%s)"

dir_self="$( cd $(dirname $0);pwd )"
pushd $dir_self >/dev/null

#source $dir_self/config.cfg

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

run(){
    print func
commander_try    cleanup #2>/dev/null
#trap trap_exit_outside_sh EXIT SIGINT 

    #trap trap_exit_outside_sh EXIT SIGINT; 


( commander "$docker_cmd_i" )
}

steps(){
    print func
    #local arg=${1:-}
    commander set_env_docker_cmds
    #commander mkdir -p /tmp/linno_pro_tmp
    #commander "$arg"
    commander run
}



trap_exit_outside(){

  local res=$?
  print func $res
  cleanup
  subject="$LOGNAME]  outside: $( date +%H:%M:%S) ] $res"
  
  #trace some error has occured !
 commander_try "./mail_for_fix.sh brownman '$subject' $file_report"
#commander_try ./mail_for_fix.sh
return $res
}

#cmd_hold_fingers="./outside.sh run bash -c ./inside.sh"
#trap 'trap_exit1' EXIT

start_outside(){
local cmd_hold_fingers=steps
#"bash -c ./inside.sh"
export -f trap_exit_outside


trap 'trap_exit_outside' EXIT SIGINT;
set +e

( commander_try "$cmd_hold_fingers  &> >(tee $file_report);"  )  
}

start_outside
popd >/dev/null
