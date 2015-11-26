FROM   xeor/wetty
#ubuntu:14.04.2
MAINTAINER  brownman "ofer.shaham@gmail.com"
#https://hub.docker.com/r/brownman/root/builds/


# Install node & npm
RUN apt-get -qqy update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install vim git \
    curl wget \
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



#RUN ln -s /usr/bin/nodejs /usr/bin/node
#
# Install Wetty
#WORKDIR /opt/wetty
#RUN git clone https://github.com/krishnasrinivas/wetty.git . && \
#    git reset --hard 223b1b1

#RUN npm install
#
#     # Set-up term user
#     RUN useradd -d /home/term -m -s /bin/bash term
#     RUN echo 'term:term' | chpasswd
#     RUN sudo adduser term sudo
#
#EXPOSE 3000
#
#     CMD env | grep -v 'HOME\|PWD\|PATH' | while read env; do echo "export $env" >> /home/term/.bashrc ; done && \


#RUN     echo "root ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
#RUN     service sudo restart

#RUN 		adduser --disabled-login --gecos 'GitLab CI user' root
USER		root
ENV 		HOME /root

WORKDIR 	/root
#ENV cmd_start 'git clone https://github.com/brownman/linno_pro.git; mv $HOME/linno_pro/* .;chmod 755 $HOME/*.sh;bash -c ./inside.sh'

#RUN mkdir -p $HOME/.ssh
#RUN echo 'echo 1>&2 "-------------------------> loading $HOME/.bashrc";echo 1>&2 "[cmd]$cmd_start"; eval "$cmd_start"' >> $HOME/.bashrc

#RUN sudo chmod 755 $HOME/*.sh


#CMD node /opt/wetty/app.js -p 3000
#CMD [ "bash" , "-c" , "ls -la $HOME" ]
