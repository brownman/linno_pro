#!/usr/bin/env bash


source config.cfg

dev_user=${1:-shahar}
subject=${2:-my_pub_key}
file_input=${3:-$HOME/.ssh/id_rsa.pub}

domain=linnovate
endings=net

dpkg -l mailutils &>/dev/null || { sudo apt-get install mailutils -y -q; }
dpkg -l sendmail &>/dev/null || { sudo apt-get install sendmail -y -q; }


commander "cat $file_input  | mail -s \"$LOGNAME] $subject:\" ${dev_user}@${domain}.${endings}"
