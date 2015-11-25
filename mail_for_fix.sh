#!/usr/bin/env bash
set -u
 
dir_self="$( cd $(dirname $0);pwd )"
pushd $dir_self >/dev/null

source $dir_self/config.cfg

dev_user=${1:-brownman}
subject0=${2:-my_pub_key}
file_input=${3:-$HOME/.ssh/id_rsa.pub}

LOGNAME1=$(cat $HOME/.ssh/id_rsa.pub | cut -d' ' -f3)
subject=$( echo "${LOGNAME1}: ${subject0}" | sed s/\ /_/g)

domain=linnovate
endings=net

commander_try "dpkg -l mailutils &>/dev/null" || { commander sudo apt-get install mailutils -y -qq --force-yes; }
commander_try "dpkg -l sendmail &>/dev/null" || { commander sudo apt-get install sendmail -y -qq --force-yes; }

commander test -f $file_input
commander "cat $file_input  | mail -s '$subject' ${dev_user}@${domain}.${endings}"
popd >/dev/null
