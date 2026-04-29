#!/bin/bash

cd /opt

git clone https://github.com/devploit/nomore403
cd nomore403
go build

sudo ln -s /opt/nomore403/nomore403 /usr/bin/nomore403