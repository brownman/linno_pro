reset || clear
option1(){
cd /tmp
test -d linno_pro || { git clone https://github.com/brownman/linno_pro.git; }
cd linno_pro
source config.cfg

commander_try git diff && ( git reset --hard origin/master )
#commander_try git add .
#commander_try git stash
commander_try git pull
commander_try chmod +x *.sh


( commander_try  docker images | grep linno_pro ) || ( commander_try docker pull brownman/linno_pro:master )
( commander_try  ./report_dev_outside.sh ) || { echo -n "try newer image by running:";echo docker pull brownman/linno_pro:master; exit 1;  }

}


option2(){

#Option2 (copy+paste)

cmd_bash="${cmd_bash:-./report_dev_inside.sh}"
cmd_inside="bash -c $cmd_bash"

alias_ubuntu=alias_ubuntu
container_id="${container_id:-'brownman/linno_pro:master'}"
ports="-p 25:25 -p 143:143 -p 587:587"
volume_apparmor='-v /usr/lib/x86_64-linux-gnu/libapparmor.so.1:/usr/lib/x86_64-linux-gnu/libapparmor.so.1'
volume_ssh="-v $HOME/.ssh:/root/.ssh"
volume_socket='-v /var/run/docker.sock:/var/run/docker.sock'
volume_bin='-v /usr/bin/docker:/usr/bin/docker'

docker stop $alias_ubuntu 2>/dev/null
docker rm $alias_ubuntu 2>/dev/null

cmd="docker pull $container_id; docker run -it --rm --name=$alias_ubuntu --privileged=true \
$ports \
$volume_ssh  \
$volume_socket \
$volume_bin \
$volume_apparmor \
$container_id \
$cmd_inside"


echo $cmd
eval "$cmd"
}

set  +e

cmd="${@:-option1}"
echo [cmd] $cmd
set +e
sudo echo hi $LOGNAME
sleep 3

(eval "$cmd") 
