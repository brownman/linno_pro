#!/usr/bin/env bash
#!/usr/bin/env bash
set +e
set -u

cd $HOME
source config.cfg
commander_try "chmod +x *.sh"
file_report="/tmp/all_$(date +%s)"




user=${1:-user}
subject=${2:-college}
run_type=${3:-all}
step_focus=${4:-}

test -f /tmp/container && {  subject=$(cat /tmp/container | head -1 ); }

url1="https://gitlab.linnovate.net/brownman/dockerizing_projects.git"
url2="git@gitlab.linnovate.net:brownman/dockerizing_projects.git"


commander_try test -d  /tmp/dockerizing_projects || { \
commander_try git clone $url1 /tmp/dockerizing_projects
}
test $? -eq 0 && { \
commander cd /tmp/dockerizing_projects
#git config --global user.email "you@example.com"
#git config --global user.name "Your Name"
#commander git add .
#commander git stash
commander_try cat .git/config 
commander_try git reset --hard origin/master
commander git pull
commander chmod +x .ci.sh
cmd_final="echo ./.ci.sh $user $subject $run_type $step_focus"
commander_try 'sleep 3; clear'
figlet "cmd: $cmd_final"
commander sleep 10
commander "$cmd_final"
} || {
  print error failed to clone
}

trap_exit_inside(){
  local res=$?
  print func
 # subject="$LOGNAME]  $( date +%H:%M:%S) ] inside: $res"

  #commander_try "$HOME/mail_for_fix.sh brownman '$subject' $file_report"
  #commander_try $HOME/mail_for_fix.sh
  return $res
}

#subject=''
#type_user=user

start_inside(){
local cmd_hold_fingers="bash -c $HOME/inside.sh"
#$type_user $subject" 
export -f trap_exit_inside
#trap 'trap_exit_inside' EXIT
set +e;
trap 'trap_exit_inside' EXIT SIGINT; 
( commander_try "$cmd_hold_fingers  &> >(tee $file_report);"  )
}

start_inside
