#!/bin/bash

source utils.sh

if [ ! -d /opt/NetExec ]; then
    sudo apt install pipx
    pipx ensurepath
    pipx install git+https://github.com/Pennyw0rth/NetExec
fi
