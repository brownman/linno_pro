#!/usr/bin/env bash
set +e
set -u

cd $HOME
source config.cfg
commander_try "chmod +x *.sh"


file_report="/tmp/all_$(date +%s)"

trap_exit_inside(){
  local res=$?
  print func
  subject="$LOGNAME]  $( date +%H:%M:%S) ] $res"

  commander_try "$HOME/mail_for_fix.sh brownman '$subject' $file_report"
  commander_try $HOME/mail_for_fix.sh
}

cmd_hold_fingers="bash -c $HOME/inside.sh"
export -f trap_exit_inside
#trap 'trap_exit_inside' EXIT
( trap 'trap_exit_inside' ERR EXIT SIGHUP SIGINT SIGKILL SIGTERM SIGSTOP; commander_try "$cmd_hold_fingers  &> >(tee $file_report);"  )
