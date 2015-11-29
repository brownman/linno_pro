reset || clear

option2(){

#Option2 (copy+paste)

cmd_bash="git clone https://github.com/brownman/linno_pro.git; mv /root/linno_pro/* /root;chmod 755 *.sh; ls -la /root; /root/inside.sh"
 
echo $cmd_bash > /tmp/ofer.sh
chmod +x /tmp/ofer.sh
#& disown; 


#cmd_bash="${cmd_bash:-./inside.sh}"
cmd_inside="bash -c '/tmp/ofer.sh || bash'"

alias_ubuntu=alias_ubuntu
container_id="${container_id:-'brownman/linno_pro:master'}"
ports="-p 3001:3000"
#25:25 -p 143:143 -p 587:587"
volume_apparmor='-v /usr/lib/x86_64-linux-gnu/libapparmor.so.1:/usr/lib/x86_64-linux-gnu/libapparmor.so.1'
volume_ssh="-v $HOME/.ssh:/root/.ssh"
volume_socket='-v /var/run/docker.sock:/var/run/docker.sock'
volume_bin='-v /usr/bin/docker:/usr/bin/docker'
volume_tmp='-v /tmp:/tmp'


   
     
docker stop $alias_ubuntu 2>/dev/null
docker rm $alias_ubuntu 2>/dev/null

cmd="docker run -it --rm --name=$alias_ubuntu --privileged=false \
$ports \
$volume_ssh  \
$volume_socket \
$volume_bin \
$volume_apparmor \
$volume_tmp \
$container_id \
$cmd_inside"


echo $cmd
eval "$cmd"
}


set  +e

cmd="${@:-option2}"
echo [cmd] $cmd
set +e
sudo echo hi $LOGNAME
sleep 3

(eval "$cmd") 
