#!/bin/bash

wget https://github.com/lsd-rs/lsd/releases/download/v1.0.0/lsd-musl_1.0.0_amd64.deb -O /tmp/lsd.deb
sudo dpkg -i /tmp/lsd.deb