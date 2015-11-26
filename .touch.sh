source config.cfg  &>/dev/null

disk_space(){
    commander_try "df -h | grep /dev/mapper/docker0--vg-root | grep  100" &&  { \
    print error disk space usage: 100%
    exit 1
    } || true
}
disk_space
test $# -ne 0 || { echo please enter a commit message: trello_id:X msg:X; exit 1; }
arg1="$@"
msg0="'$( date +%H:%M )'"
msg="${arg1:-$msg0}"
test -d .old1 || { mkdir .old1; }
echo 1 >> .old1/.dirty
git add -A


cmd="git commit -am  '$msg'"
echo $cmd
eval "$cmd"

git push 

