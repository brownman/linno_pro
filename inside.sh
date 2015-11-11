#!/usr/bin/env bash
user=${1:-user}
subject=${2:-college}
run_type=${3:-all}
step_focus=${4:-}

git clone git@gitlab.linnovate.net:brownman/dockerizing_projects.git /tmp/dockerizing_projects
cd /tmp/dockerizing_projects
chmod +x .ci.sh
./.ci.sh $user $subject $run_type $step_focus