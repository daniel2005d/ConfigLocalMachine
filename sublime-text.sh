#!/bin/bash
source utils.sh
if ! dpkg -l |grep -q sublime-text;
then
    print_info "Installing Sublime-Text"
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
    echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
    sudo apt update
    sudo apt -y install sublime-text
fi