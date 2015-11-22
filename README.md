[docker hub build status](https://hub.docker.com/r/brownman/linno_pro/builds/)


linnovate project magic (aka: linno_pro )
======

### requirements: docker

```bash
( docker -v | egrep -h 1.8\|1.9 ) || ( curl -o- https://raw.githubusercontent.com/brownman/linno_pro/master/docker_install.sh | bash )
#or: wget -qO- https://raw.githubusercontent.com/brownman/linno_pro/master/docker_install.sh | bash
```



### how to run ?
```bash
curl -o- https://raw.githubusercontent.com/brownman/linno_pro/master/linno_pro.sh | bash
#or: wget -qO- https://raw.githubusercontent.com/brownman/linno_pro/master/linno_pro.sh | bash
```


how to build image:
---------

```bash
container_id=brownman/linno_pro
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
