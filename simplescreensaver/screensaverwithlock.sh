#!/bin/bash
# screensaver.sh

# url: ###
# This script is licensed under GNU GPL version 2.0 or above

# Uses elements from lightsOn.sh
# Copyright (c) 2011 iye.cba at gmail com
# url: https://github.com/iye/lightsOn
# This script is licensed under GNU GPL version 2.0 or above

# Description: ####
# screensaver.sh needs xprintidle and feh to work.

# HOW TO USE: Start the script with the number of seconds you want the checks
# for fullscreen to be done. Example:
# "./screensaver.sh 120"

# enumerate all the attached screens
displays=""
while read id
do
    displays="$displays $id"
done< <(xvinfo | sed -n 's/^screen #\([0-9]\+\)$/\1/p')

DIR=$( cd "$( dirname "$0" )" && pwd)
delay=$1

checkFullscreen()
{

    # loop through every display looking for a fullscreen window
    for display in $displays
    do
        #get id of active window and clean output
        activ_win_id=`DISPLAY=:0.${display} xprop -root _NET_ACTIVE_WINDOW`
        activ_win_id=${activ_win_id:40:9}
        
        # Check if Active Window (the foremost window) is in fullscreen state
        isActivWinFullscreen=`DISPLAY=:0.${display} xprop -id $activ_win_id | grep _NET_WM_STATE_FULLSCREEN`
            if [[ "$isActivWinFullscreen" != *NET_WM_STATE_FULLSCREEN* ]];then
		oldIdle=0
                feh -x -F -r -Y -Z -z -A slideshow -D 7 -d $DIR &
		while sleep $((1)); do
		         idle=$(xprintidle)
		         if [ $oldIdle -ge $idle ]; then
			     gnome-screensaver-command -l
			     break
		         fi
			 oldIdle=$idle
		done
	    fi
    done
}

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
        checkFullscreen
    fi
done

exit 0
