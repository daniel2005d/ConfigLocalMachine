#!/bin/bash

source utils.sh
if [ ! -f /usr/bin/codium ];
then
    sudo apt install pgp
    print_info "Register KeyRing"
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    rm -f packages.microsoft.gpg
    sudo apt update
    sudo apt -y install code
    if [ ! -f /usr/bin/code ];
    then
        print_info "Creating Symlink to Code"
        if [ -f /usr/bin/codium ];then
            sudo ln -s /usr/bin/codium /usr/bin/code
        fi
    fi

    print_info "Installing Extensions"
    code --install-extension streetsidesoftware.code-spell-checker  --force
    code --install-extension ms-python.python --force
    code --install-extension  silofy.hackthebox --force
fi