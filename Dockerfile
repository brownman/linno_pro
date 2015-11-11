 Dockerfile.drupal.user                                                                                                                                                         
FROM    ubuntu:14.04.2

RUN apt-get update -qq -y
RUN cat /etc/resolv.conf


RUN DEBIAN_FRONTEND=noninteractive apt-get -y install git vim curl wget \
ssh  \
rsync  \
figlet \
xsel \
toilet \
pv \
tree

CMD [ "bash" , "-c" , "cat README.md" ]
