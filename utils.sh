#!/bin/bash

greenColour="\e[32m"
yellowColour="\e[33m"
redColour="\e[31m"
blueColour="\e[34m"
magentaColour="\e[34m"
reset="\e[0m"

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