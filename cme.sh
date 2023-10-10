#!/bin/bash

source utils.sh

if [ ! -d /opt/CrackMapExec ]; then
    cd /opt/
    git clone https://github.com/Porchetta-Industries/CrackMapExec
    cd /opt/CrackMapExec;pipx install .
    cd -
     
fi