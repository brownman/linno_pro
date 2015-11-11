FROM   ubuntu:14.04.2
USER   root
WORKDIR /home/linno_pro
ENV HOME /home/linno_pro
COPY . $HOME

RUN apt-get update -qq -y
RUN cat /etc/resolv.conf


RUN DEBIAN_FRONTEND=noninteractive apt-get -y install git vim curl wget \
ssh  \
rsync  \
figlet \
xsel \
toilet \
pv \
tree \
sudo

#CMD   . $HOME/.bashrc

#RUN git clone --depth=1 https://github.com/brownman/install_config_test 
#RUN cd install_config_test && chmod u+x travis.sh && ./travis.sh mean
RUN sudo chmod 755 $HOME/start.sh #&& bash -c $HOME/start.sh 

CMD [ "bash" , "-c" , "cat $HOME/README.md" ]
