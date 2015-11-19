#!/usr/bin/env bash
file_report="/tmp/all_$(date +%s)"

echo cd /tmp
cd /tmp

echo source config.cfg
source config.cfg

commander_try test -d linno_pro || { commander git clone https://github.com/brownman/linno_pro.git; }
commander cd linno_pro

commander_try git pull
commander_try chmod +x *.sh

commander_try docker pull brownman/linno_pro
cmd_hold_fingers="./outside.sh run ./inside.sh &>$file_report"

( commander_try "$cmd_hold_fingers" )  || ( commander ./mail_for_fix.sh brownman \'$cmd_hold_fingers\' $file_report )
