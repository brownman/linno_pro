#!/usr/bin/env bash
file_report="/tmp/all_$(date +%s)"

cmd_hold_fingers="./outside.sh run ./inside.sh &>$file_report"

( commander_try "$cmd_hold_fingers" )  || ( commander ./mail_for_fix.sh brownman \'$cmd_hold_fingers\' $file_report )
