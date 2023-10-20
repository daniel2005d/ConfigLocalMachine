#!/bin/bash

if [ ! -d /opt/sqlmap ]; then
    cd /opt; git clone https://github.com/sqlmapproject/sqlmap.git 
    if [ ! -f /usr/bin/sqlmap ]; then
        sudo ln -s /opt/sqlmap/sqlmap /usr/bin/sqlmap  
    fi
    
fi