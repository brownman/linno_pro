reset || clear
source config.cfg
option2(){
commander set_env_docker_cmds
commander_try cleanup
commander docker_run_it 
}


set  +e

cmd="${@:-option2}"
echo [cmd] $cmd
set +e
sudo echo hi $LOGNAME
sleep 3

(eval "$cmd") 
