option1(){
#option 1:
##http://www.ubuntuupdates.org/ppa/docker_new?dist=ubuntu-$name
distro=$( lsb_release -a  | grep Codename | cut -d':' -f2 | xargs )
sudo apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
#setup the repository:
sudo sh -c "echo deb https://apt.dockerproject.org/repo ubuntu-${distro} main \
    > /etc/apt/sources.list.d/docker.list"
sudo apt-get update
sudo apt-get install docker-engine -y --force-yes
sudo usermod -aG docker $LOGNAME
}


option2(){
#option 2:
sudo apt-get purge docker docker.io
wget -qO- https://get.docker.com/ | sh
wget -qO- https://get.docker.com/gpg | sudo apt-key add -
ln -sf /usr/bin/docker /usr/local/bin/docker
sudo usermod -aG docker $LOGNAME
}


#option3
#goto: https://github.com/docker/docker/tree/master/experimental
cmd=${1:-option1}
echo [cmd] $cmd
eval "$cmd"
