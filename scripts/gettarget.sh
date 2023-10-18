#!/bin/bash

######################
# Gets the value of the file a that has the IP address of 
# the target to be audited.
######################

if [ -f $HOME/.config/.target ];
then
    TARGET=$(cat $HOME/.config/.target)
    echo "󰓾 $TARGET"
else
    echo " "
fi