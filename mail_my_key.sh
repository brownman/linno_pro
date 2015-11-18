#!/usr/bin/env bash

dev_user=${1:-shahar}
domain=linnovate
endings=net
sudo apt-get install mailutils -y -q
sudo apt-get install sendmail -y -q
cat $HOME/.ssh/id_rsa.pub  | mail -s "from $LOGNAME my_pub_key:" ${dev_user}@${domain}.${endings}
