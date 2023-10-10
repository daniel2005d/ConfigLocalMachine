#!/bin/bash
source utils.sh

if [ ! -d /opt/ffuf ]; then
    cd /opt
    git clone https://github.com/ffuf/ffuf
    cd /opt/ffuf;go get;go build
    cd -
    if [ ! -f /usr/bin/ffuf ] then;
        sudo ln -s /opt/ffuf/ffuf /usr/bin/ffuf  
    fi
fi