#!/bin/bash

print_info(){
    echo -e "\e[31m$1\e[0m"
}

replace_homefolder(){
    /usr/bin/sed -i "s|custom_HOME|$HOME|g" $1
}

create_if_notexists(){
    if [ ! -d $1 ]; then
        print_info "Creating Folder $1"
        /usr/bin/mkdir $1
    fi
}