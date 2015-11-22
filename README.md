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
sudo usermod -aG docker $LOGNAME

#option 2:
sudo apt-get purge docker docker.io
wget -qO- https://get.docker.com/ | sh
wget -qO- https://get.docker.com/gpg | sudo apt-key add -
ln -sf /usr/bin/docker /usr/local/bin/docker
sudo usermod -aG docker $LOGNAME

#option3
#goto: https://github.com/docker/docker/tree/master/experimental
```



### how to run ?
```
curl -o- https://raw.githubusercontent.com/brownman/linno_pro/master/linno_pro.sh | bash
#or
wget -qO- https://raw.githubusercontent.com/brownman/linno_pro/master/linno_pro.sh | bash
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
