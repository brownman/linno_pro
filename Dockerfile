FROM   ubuntu:14.04.2
MAINTAINER  brownman "ofer.shaham@gmail.com"
#https://hub.docker.com/r/brownman/root/builds/

RUN apt-get update -qq -y

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install git vim curl wget \
ssh  \
rsync  \
figlet \
xsel \
toilet \
pv \
tree \
sudo \
mailutils \
sendmail

RUN     echo "root ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN     service sudo restart

RUN 		adduser --disabled-login --gecos 'GitLab CI user' root
USER		root
ENV 		HOME /root

WORKDIR 	/root
ADD . $HOME

RUN mkdir -p $HOME/.ssh
RUN echo 'echo "-------------------------> loading $HOME/.bashrc"' >> $HOME/.bashrc

RUN sudo chmod 755 $HOME/*.sh

CMD [ "bash" , "-c" , "cat $HOME/.ssh/id_rsa.pub" ]
