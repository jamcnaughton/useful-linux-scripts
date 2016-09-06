#!/bin/bash
# screensaverfull.sh

# url: ###
# This script is licensed under GNU GPL version 2.0 or above

# Uses elements from lightsOn.sh
# Copyright (c) 2011 iye.cba at gmail com
# url: https://github.com/iye/lightsOn
# This script is licensed under GNU GPL version 2.0 or above

# Description: ####
# screensaverfull.sh needs xprintidle and feh to work.

# HOW TO USE: Start the script with the number of seconds you want the checks
# for fullscreen to be done. Example:
# "./screensaver.sh 120"

DIR=$( cd "$( dirname "$0" )" && pwd)
delay=$1


# If argument empty, use 60 seconds as default.
if [ -z "$1" ];then
    delay=60
fi

# If argument is not integer quit.
if [[ $1 = *[^0-9]* ]]; then
    echo "The Argument \"$1\" is not valid, not an integer"
    exit 1
fi

IDLE_TIME=$(($delay*1000))

cd $DIR
while sleep $((1)); do
    idle=$(xprintidle)
    if [ $idle -ge $IDLE_TIME ]; then
        feh -x -F -r -Y -Z -z -A slideshow -D 7 -d $DIR
    fi
done

exit 0
