#!/bin/bash
source utils.sh

if ! command -v run-httpserver > /dev/null; then
    print_info "Installing HttpServer"
    cd /opt;git clone https://github.com/daniel2005d/HttpServer.git
    cd /opt/HttpServer/Server
    pip install -e . --break-system-packages
fi

if ! command -v run-metadata > /dev/null; then
    print_info "Installing scripts"
    cd /opt;git clone https://github.com/daniel2005d/scripts.git
    cd /opt/scripts
    pip install -e . --break-system-packages
fi
