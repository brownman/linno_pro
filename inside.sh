#!/usr/bin/env bash


user=${1:-user}
subject=${2:-college}
run_type=${3:-all}
step_focus=${4:-}

source $HOME/config.cfg


commander_try test -d  /tmp/dockerizing_projects || { \
( commander_try git clone https://gitlab.linnovate.net/brownman/dockerizing_projects.git /tmp/dockerizing_projects)
}

commander cd /tmp/dockerizing_projects
commander git pull
commander chmod +x .ci.sh
commander ./.ci.sh $user $subject $run_type $step_focus
