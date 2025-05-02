#!/bin/bash



print_info "Installing HttpServer"
cd /opt;git clone https://github.com/daniel2005d/HttpServer.git
cd /opt/HttpServer
pip install -e . --break-system-packages.

print_info "Installing scripts"
cd /opt;git clone https://github.com/daniel2005d/scripts.git
cd /opt/scripts
pip install -e . --break-system-packages.
