#!/usr/bin/env bash
set +e
set -u
cd /tmp/linno_pro
source config.cfg
file_report="/tmp/all_$(date +%s)"
trap_exit1(){
    local res=$?
  print func
  subject="$LOGNAME]  $( date +%H:%M:%S) ] $res"

  commander_try "./mail_for_fix.sh brownman '$subject' $file_report"
  commander_try ./mail_for_fix.sh
}
cmd_hold_fingers="./outside.sh run ./report_dev_inside.sh"
export -f trap_exit1
#trap 'trap_exit1' EXIT
( trap 'trap_exit1' EXIT; commander_try "$cmd_hold_fingers  &> >(tee $file_report);"  )
