#!/bin/bash

greenColour="\e[32m"
yellowColour="\e[33m"
redColour="\e[31m"
blueColour="\e[34m"
magentaColour="\e[34m"
reset="\e[0m"

INSTALLERS=$(pwd)'/installer'
FILES_DIRECTORY=$(pwd)'/files'
ICONS_DIRECTORY=$(pwd)'/icons'
SCRIPTS_DIRECTORY=$(pwd)'/scripts'
TERMINAL_ICON=$ICONS_DIRECTORY/utilities-terminal.svg
LOCAL_FOLDER=$HOME/.local/share
GLOBAL_ICONS_FOLDER=/usr/share/icons
FONTS_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Hack.zip"
GRUB="/etc/default/grub"
ERROR_FILE="log.txt"

print_info(){
    color=$2
    if [ -z "$2" ]; then
       color=$greenColour
    fi

    echo -e "$color $1 $reset"
}

replace_homefolder(){
    /usr/bin/sed -i "s|custom_HOME|$HOME|g" $1
}

create_if_notexists(){
    if [ ! -d $1 ]; then
        print_info "Creating Folder $1" $yellowColour
        /usr/bin/mkdir -p $1
    fi
}