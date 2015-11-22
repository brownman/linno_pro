#!/usr/bin/env bash


user=${1:-user}
subject=${2:-college}
run_type=${3:-all}
step_focus=${4:-}
url1="https://gitlab.linnovate.net/brownman/dockerizing_projects.git"
url2="git@gitlab.linnovate.net:brownman/dockerizing_projects.git"
source $HOME/config.cfg


commander_try test -d  /tmp/dockerizing_projects || { \
commander_try git clone $url1 /tmp/dockerizing_projects
}
test $? -eq 0 && { \
commander cd /tmp/dockerizing_projects
#git config --global user.email "you@example.com"
#git config --global user.name "Your Name"
commander_try cat .git/config 
commander git add .
commander git stash
commander git pull
commander chmod +x .ci.sh
commander ./.ci.sh $user $subject $run_type $step_focus
} || {
  print error failed to clone
}
