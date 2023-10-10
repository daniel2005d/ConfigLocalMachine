#!/bin/bash

if [ ! -d /opt/ffuf ]; then
    git clone https://github.com/ffuf/ffuf -o /opt/ffuf
    cd /opt/fuff
    go get
    go build
    sudo ln -s /opt/ffuf/ffuf /usr/bin/ffuf  
fi