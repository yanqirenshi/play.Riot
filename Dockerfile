# ################################################################
#
#
#  Prior work
#  ==========
#   export PLAY_RIOT_GIT_NAME="yanqirenshi"
#   export PLAY_RIOT_GIT_EMAIL="yanqirenshi@gmail.com"
#
#  Build
#  =====
#   docker build -t play.Riot .
#
#  Run
#  ===
#   docker run -v ~/.ssh:/home/riot/.ssh -env PLAY_RIOT_GIT_NAME={} -env PLAY_RIOT_GIT_EMAIL={} -it play.riot /bin/bash
#
#  Start
#  ===
#   sh /home/h/tmp/setup.sh
#
# ################################################################

FROM debian:buster

MAINTAINER Renshi <yanqirenshi@gmail.com>

#####
##### Install Packages
#####
USER root

RUN apt update
RUN apt install -y build-essential
RUN apt install -y curl
RUN apt install -y emacs
RUN apt install -y nginx
RUN apt install -y git


#####
##### Make Group / User
#####
USER root

RUN groupadd riot-users
RUN useradd -d /home/riot -m -g riot-users riot


#####
##### Make User's Directory
#####
USER riot
WORKDIR /home/riot

RUN mkdir /home/riot/prj
RUN mkdir /home/riot/tmp
RUN mkdir -p /home/riot/.emacs.d/dist


#####
##### Setting Emacs
#####
USER riot
WORKDIR /home/riot/.emacs.d/dist
# SHELL ["/bin/bash", "--login", "-c"]

RUN git clone https://github.com/yanqirenshi/emacs.git

RUN touch /home/riot/.emacs.d/init.el
RUN echo '(load "~/.emacs.d/dist/emacs/init-base.el")'  >> /home/riot/.emacs.d/init.el

RUN emacs --script /home/riot/.emacs.d/dist/emacs/src/package.el


#####
##### Install nvm & node
#####
USER riot
WORKDIR /home/riot

SHELL ["/bin/bash", "--login", "-c"]
# RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
RUN curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
RUN nvm install 10.16.3 && nvm use 10.16.3

RUN npm i -g riot riotjs-loader babel babel-loader webpack webpack-dev-server @babel/core

#####
##### Start
#####
USER riot
WORKDIR /home/riot
 
COPY setup.sh /home/riot/tmp/
