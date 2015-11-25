#!/usr/bin/env bash
set +e
set -u
cd /tmp/linno_pro
source config.cfg
file_report="/tmp/all_$(date +%s)"
trap_exit_outside(){

  local res=$?
  print func $res
  subject="$LOGNAME]  outside: $( date +%H:%M:%S) ] $res"
  
  #trace some error has occured !
 commander_try "./mail_for_fix.sh brownman '$subject' $file_report"
#commander_try ./mail_for_fix.sh
return $res
}
cmd_hold_fingers="./outside.sh run bash -c ./report_dev_inside.sh"
export -f trap_exit_outside
#trap 'trap_exit1' EXIT

trap 'trap_exit_outside' EXIT SIGINT;
set +e
(  commander_try "$cmd_hold_fingers  &> >(tee $file_report);"  )  
