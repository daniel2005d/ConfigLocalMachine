#!/bin/bash

if [ ! -d /opt/CrackMapExec ]; then
    git clone https://github.com/Porchetta-Industries/CrackMapExec -o /opt/CrackMapExec
    cd /opt/CrackMapExec
    pipx install .
     
fi