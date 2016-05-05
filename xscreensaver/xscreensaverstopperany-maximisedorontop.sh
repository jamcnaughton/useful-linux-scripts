#!/bin/bash
# xscreensaverstopper.sh

# This script is licensed under GNU GPL version 2.0 or above

# Uses elements from lightsOn.sh
# Copyright (c) 2011 iye.cba at gmail com
# url: https://github.com/iye/lightsOn
# This script is licensed under GNU GPL version 2.0 or above

# Description: Restarts xscreensaver's idle countdown while 
# full screen applications are running.  
# Checks every 30 seconds to see if any windows are maximised
# if so then xscreensaver is told to restart its idle countdown.


# enumerate all the attached screens
displays=""
while read id
do
    displays="$displays $id"
done< <(xvinfo | sed -n 's/^screen #\([0-9]\+\)$/\1/p')

checkFullscreen()
{

    # loop through every display looking for a fullscreen window
    for display in $displays
    do

	WIN_IDs=$(wmctrl -l | awk '$3 != "N/A" {print $1}')
	for i in $WIN_IDs; do 
        	isWinMax=`DISPLAY=:0.${display} xprop -id "$i" | grep _NET_WM_STATE MAXIMIZED VERT`
        	isWinOnTop=`DISPLAY=:0.${display} xprop -id "$i" | grep _NET_WM_STATE_ABOVE`
		if [[ "$isWinMax" == *NET_WM_STATE MAXIMIZED VERT* ] ||[ "$isWinOnTop" == *NET_WM_STATE_ABOVE* ]];then
              		xscreensaver-command -deactivate
	    	fi
	done
    done
}

while sleep $((30)); do
    checkFullscreen
done

exit 0
