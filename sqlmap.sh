#!/bin/bash

if [ ! -d /opt/sqlmap ]; then
    git clone https://github.com/sqlmapproject/sqlmap.git -o /opt/sqlmap
    sudo ln -s /opt/sqlmap/sqlmap /usr/bin/sqlmap  
fi