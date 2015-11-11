[docker hub build status](https://hub.docker.com/r/brownman/linno_pro/builds/)


linno_pro
======


### how to run


```bash
alias_ubuntu=alias_ubuntu
container_id='brownman/linno_pro:master'

volume_apparmor='-v /usr/lib/x86_64-linux-gnu/libapparmor.so.1:/usr/lib/x86_64- linux-gnu/libapparmor.so.1'
volume_ssh="-v $HOME/.ssh:/root/.ssh"
volume_socket='-v /var/run/docker.sock:/var/run/docker.sock'
volume_bin='-v /usr/bin/docker:/usr/bin/docker'

docker run -it --name=$alias_ubuntu --privileged=true \
$volume_ssh  \
$volume_socket \
$volume_bin \
$volume_apparmor \
$container_id \
bash -c inside.sh
```
