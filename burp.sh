#!/bin/bash

source utils.sh

if [ ! -f /usr/local/bin/BurpSuitePro ];
then
    if [ -f $INSTALLERS/burpsuite_pro.sh ];
    then
        sudo bash $INSTALLERS/burpsuite_pro.sh
    fi
fi