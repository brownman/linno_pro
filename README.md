[docker hub build status](https://hub.docker.com/r/brownman/linno_pro/builds/)
  
  
  
    
   
linnovate project magic (aka: linno_pro )
======

### requirements: docker

```bash
( docker -v | egrep -h 1.8\|1.9 ) || ( curl -o- https://raw.githubusercontent.com/brownman/linno_pro/master/docker_install.sh |  bash )
#or: wget -qO- https://raw.githubusercontent.com/brownman/linno_pro/master/docker_install.sh |  bash
```



### ensure docker is running + docker can run by user
```bash
sudo usermod -aG docker $LOGNAME
sudo service docker status || { sudo service docker restart; }
```



### how to run ?
```bash
docker pull brownman/linno_pro:master

curl -o- https://raw.githubusercontent.com/brownman/linno_pro/master/linno_pro.sh |  bash
```

### login the terminal via the browser
```bash
google-chrome-stable 0.0.0.0:3002
```

--------


####  Troobleshoot: 

- share my public key with IT department:

```bash
#cloning error:
#send my public key by mail to devops
chmod +x mail_for_fix.sh
bash -c mail_for_fix.sh
```

- password-less SSH login:

```bash

cd $HOME/.ssh
ssh-keygen -f id_rsa -p
```


