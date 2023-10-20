#!/bin/bash

ip=$(hostname -I | grep -E "[0-9]{1,}\.[0-9]{1,}\.[0-9]{1,}\.[0-9]{1,}" -o)
    if [ "$XDG_CURRENT_DESKTOP" = "XFCE" ];
    then
    	if [ $ip != "" ];
    	then
        	echo "<icon>currentip</icon><txt><span fgcolor='#cc9b06' >  $ip</span></txt>"
        else
        	echo "<icon>noipservice</icon><txt><span fgcolor='#cc9b06' >  $ip</span></txt>"
        fi
    
    else
        echo "󰒄  $ip"
    fi