#!/bin/sh

git config --global user.name  $PLAY_RIOT_GIT_NAME
git config --global user.email $PLAY_RIOT_GIT_EMAIL

cd ~/prj
git clone git@github.com:yanqirenshi/play.Riot.git
