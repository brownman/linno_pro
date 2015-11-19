#!/usr/bin/env bash
set +e
set -u
cd /tmp/linno_pro
file_report="/tmp/all_$(date +%s)"
trap_exit1(){
  local res=$1
  commander_try "sleep 10; ./mail_for_fix.sh brownman '$LOGNAME] $res' $file_report"
}
cmd_hold_fingers="./outside.sh run ./inside.sh"
( eval "$cmd_hold_fingers"  &> >(tee $file_report); trap 'trap_exit1 $?' EXIT )
