#!/usr/bin/env bash

dev_user=shahar
sudo apt-get install mailutils -y -q
sudo apt-get install sendmail -y -q
cat $HOME/.ssh/id_rsa.pub  | mail -s "from $LOGNAME my_pub_key:" $dev_user@linnovate.net
