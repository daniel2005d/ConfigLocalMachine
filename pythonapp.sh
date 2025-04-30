#!/bin/bash



print_info "Installing HttpServer"
cd /opt;git clone git@github.com:daniel2005d/HttpServer.git
cd /opt/HttpServer
pip install -e .

print_info "Installing scripts"
cd /opt;git clone https://github.com/daniel2005d/scripts.git
cd /opt/scripts
pip install -e .