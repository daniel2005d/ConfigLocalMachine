#!/bin/bash

source utils.sh

PACKAGES_FILE=$(pwd)/packages/list.lst
print_info "Installing Software" $blueColour
sudo apt update &>/dev/null
if [ $? -eq 0 ];
then
    packages=$(/usr/bin/cat $PACKAGES_FILE)
    while IFS= read -r line; do
        package_type=$(echo $line | cut -d '|' -f1)
        package_name=$(echo $line | cut -d '|' -f2)
        if [ $package_type == 'apt' ]; then
            if ! dpkg -l |grep -q -w $package_name ;
            then
                print_info "[+] Installing $package_name" 
                sudo apt install -y $package_name
            else
                print_info "[!] skipping $package_name" $yellowColour 
            fi
        elif [ $package_type == 'pip' ]; then
            if ! pip show $package_name >/dev/null 2>&1;
            then 
                print_info "Install python package $package_name"  
                pip install $package_name
            else
                print_info "[!] skipping $package_name" $magentaColour 
            fi
        elif [ $package_type == 'git' ]; then
                
                destination=$(echo $line | cut -d '|' -f3)
                print_info "Cloning $destination"  
                create_if_notexists $destination
                cd $destination
                git clone $package_name
                cd -
            
        elif [ $package_type == 'script' ]; then
            bash $package_name
        fi
        
    done < "$PACKAGES_FILE"

fi