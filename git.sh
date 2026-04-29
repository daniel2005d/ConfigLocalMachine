#!/bin/bash

cd /opt

if [[ ! -d "/opt/nomore403" ]];then
    git clone https://github.com/devploit/nomore403
    cd nomore403
    go build

    sudo ln -s /opt/nomore403/nomore403 /usr/bin/nomore403
fi

if [[ ! -d "/opt/wordlists/SecLists" ]];then
    git clone --depth 1 https://github.com/danielmiessler/SecLists.git /opt/wordlists/SecLists
fi