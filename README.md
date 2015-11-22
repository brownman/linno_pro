[docker hub build status](https://hub.docker.com/r/brownman/linno_pro/builds/)


linnovate project magic (aka: linno_pro )
======

### requirements: docker

```bash
version=$(docker -v | cut -d' ' -f3 | sed s/,//g | cut -d'.' -f1,2 )
docker -v | egrep -h 'Docker version 1.8'\|'Docker version 1.9'
```
### install: 
```bash

#option 1:
##http://www.ubuntuupdates.org/ppa/docker_new?dist=ubuntu-$name
distro=$( lsb_release -a  | grep Codename | cut -d':' -f2 | xargs )
apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
#setup the repository:
sudo sh -c "echo deb https://apt.dockerproject.org/repo ubuntu-${distro} main \
> /etc/apt/sources.list.d/docker.list"
sudo apt-get update
sudo apt-get install docker-engine

#option 2:
sudo apt-get purge docker docker.io
wget -qO- https://get.docker.com/ | sh
wget -qO- https://get.docker.com/gpg | sudo apt-key add -
ln -sf /usr/bin/docker /usr/local/bin/docker


```


### how to run ?

 Option1:
```
set  +e
cd /tmp
test -d linno_pro || { git clone https://github.com/brownman/linno_pro.git; }
cd linno_pro
source config.cfg

commander_try sudo usermod -aG docker $LOGNAME 
commander_try git add .
commander_try git stash
commander_try git pull
commander_try chmod +x *.sh
( commander_try  sudo docker images | grep lino_pro ) || ( commander_try sudo docker pull brownman/linno_pro:master )
( commander_try sudo ./report_dev_outside.sh )
```

 Option2 (copy+paste)

```bash
cmd_bash="${cmd_bash:-./inside.sh}"
cmd_inside="bash -c $cmd_bash"

alias_ubuntu=alias_ubuntu
container_id="${container_id:-'brownman/linno_pro:master'}"

volume_apparmor='-v /usr/lib/x86_64-linux-gnu/libapparmor.so.1:/usr/lib/x86_64-linux-gnu/libapparmor.so.1'
volume_ssh="-v $HOME/.ssh:/root/.ssh"
volume_socket='-v /var/run/docker.sock:/var/run/docker.sock'
volume_bin='-v /usr/bin/docker:/usr/bin/docker'

docker stop $alias_ubuntu 2>/dev/null
docker rm $alias_ubuntu 2>/dev/null

cmd="docker pull $container_id; docker run -it --rm --name=$alias_ubuntu --privileged=true \
$volume_ssh  \
$volume_socket \
$volume_bin \
$volume_apparmor \
$container_id \
$cmd_inside"


echo $cmd
eval "$cmd"
```


how to build image:
---------

```bash
container_id=some_name
docker build -t $container_id .
```


--------


####  Troobleshoot


git/rsync can't clone:

```bash
#send my public key by mail to devops
chmod +x mail_for_fix.sh
bash -c mail_for_fix.sh
```
