#!/bin/bash

export PORT=5100
export MIX_ENV=prod
export GIT_PATH=/home/tasktrackerapp/src/tasktrackerapp 

PWD=`pwd`
if [ $PWD != $GIT_PATH ]; then
	echo "Error: Must check out git repo to $GIT_PATH"
	echo "  Current directory is $PWD"
	exit 1
fi

if [ $USER != "tasktrackerapp" ]; then
	echo "Error: must run as user 'tasktrackerapp'"
	echo "  Current user is $USER"
	exit 2
fi

mix deps.get
(cd assets && npm install)
(cd assets && ./node_modules/brunch/bin/brunch b -p)
mix phx.digest
mix release --env=prod

mkdir -p ~/www
mkdir -p ~/old

NOW=`date +%s`
if [ -d ~/www/tasktrackerapp ]; then
	echo mv ~/www/tasktrackerapp ~/old/$NOW
	mv ~/www/tasktrackerapp ~/old/$NOW
fi

mkdir -p ~/www/tasktrackerapp
REL_TAR=~/src/tasktrackerapp/_build/prod/rel/tasktrackerapp/releases/0.0.1/tasktrackerapp.tar.gz
(cd ~/www/tasktrackerapp && tar xzvf $REL_TAR)

crontab - <<CRONTAB
@reboot bash /home/tasktrackerapp/src/tasktrackerapp/start.sh
CRONTAB

#. start.sh
