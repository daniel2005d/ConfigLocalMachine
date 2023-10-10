#!/bin/bash

if [ ! -d /opt/sqlmap ]; then
    git clone https://github.com/sqlmapproject/sqlmap.git -o /opt/sqlmap
    if [ ! -f /usr/bin/sqlmap ]; then
        sudo ln -s /opt/sqlmap/sqlmap /usr/bin/sqlmap  
    fi
    
fi