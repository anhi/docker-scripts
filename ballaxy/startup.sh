#!/bin/bash

GALAXY_ROOT_DIR=~/ballaxy
BALL_DIR=~/ball/

export LD_LIBRARY_PATH=$BALL_DIR/build/lib
export PYTHONPATH=$BALL_DIR/build/lib
export BALL_DATA_PATH=$BALL_DIR/BALL/data
export PATH=$BALL_DIR/build/bin:$BALL_DIR/build/bin/TOOLS:$PATH

cd /ballaxy/
# If /export/ is mounted, export_user_files file moving all data to /export/
# symlinks will point from the original location to the new path under /export/
# If /export/ is not given, nothing will happen in that step
python ./export_user_files.py $PG_DATA_DIR_DEFAULT
service postgresql start
# start Galaxy
./run.sh --daemon
# start Apache in Foreground, that is needed for Docker
apache2ctl -D FOREGROUND
