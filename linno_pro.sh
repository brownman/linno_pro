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
( commander_try  ./outside.sh ) || { echo -n "try newer image by running:";echo docker pull brownman/linno_pro:master; exit 1;  }

}
set  +e

cmd="${@:-option1}"
echo [cmd] $cmd
set +e
sudo echo hi $LOGNAME
sleep 3

(eval "$cmd") 
