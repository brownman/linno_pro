#!/usr/bin/env bash
set +e
set -u
cd /tmp/linno_pro
file_report="/tmp/all_$(date +%s)"

cmd_hold_fingers="./outside.sh run ./inside.sh"

commander_try "$cmd_hold_fingers" &> >(tee $file_report)  || ( commander_try ./mail_for_fix.sh brownman \'$cmd_hold_fingers\' $file_report )
