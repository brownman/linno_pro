#!/usr/bin/env bash
set -u

dir_self="$( cd $(dirname $0);pwd )"
pushd $dir_self >/dev/null

source $dir_self/config.cfg

dev_user=${1:-brownman}
subject0=${2:-my_pub_key}
file_input=${3:-$HOME/.ssh/id_rsa.pub}

subject=$( echo $subject0 | sed s/\ /_/g)

domain=linnovate
endings=net

commander "dpkg -l mailutils &>/dev/null" || { sudo apt-get install mailutils -y -q; }
commander "dpkg -l sendmail &>/dev/null" || { sudo apt-get install sendmail -y -q; }

commander assert file exist $file_input
commander "cat $file_input  | mail -s \"$LOGNAME] $subject:\" ${dev_user}@${domain}.${endings}"
popd >/dev/null
