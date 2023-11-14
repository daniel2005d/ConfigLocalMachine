#!/bin/bash

######################
# Gets the value of the file a that has the IP address of 
# the target to be audited.
# https://docs.xfce.org/panel-plugins/xfce4-genmon-plugin/start
######################



if [ -f $HOME/.config/.target ];
then

    TARGET=$(cat $HOME/.config/.target)

    if [ $XDG_CURRENT_DESKTOP == "XFCE" ];
    then
        if [[ $TARGET != "" ]]; then
		    echo "<icon>target</icon><txt><span weight='Bold' fgcolor='#9fef00'>$TARGET</span></txt>"
        else
            PUBLIC_IP=$(curl -s https://ifconfig.me)
            echo "<icon>internet</icon><txt><span weight='Bold' fgcolor='#9fef00'>$PUBLIC_IP</span></txt>"
		fi
        
    
    else
        echo "󰓾  $TARGET"
    fi
else
    echo " "
fi
