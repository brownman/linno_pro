[docker hub build status](https://hub.docker.com/r/brownman/linno_pro/builds/)


linno_pro
======


### how to run


```bash
volume_apparmor
volume_ssh=$HOME/.ssh:/root/.ssh
alias_ubuntu=alias_ubuntu
docker run -it --name=$alias_ubuntu --privileged=true $volume_ssh  -v /var/run/docker.sock:/var/run/docker.sock -v /usr/bin/docker:/usr/bin/docker brownman/linno_pro bash -c start.sh
```
