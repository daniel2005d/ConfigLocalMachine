#!/bin/bash

setsettings(){
    if [ -d $1 ]; 
        then
            original_hash=$(md5sum $1/policies.json | awk '{print $1}')
            policies_hash=$(md5sum $FILES_DIRECTORY/firefox-policies.json.j2  | awk '{print $1}')
            if [ "$original_hash" != "$policies_hash" ];
            then
                print_info "[+] Setting firefox Configuration"
                sudo /usr/bin/cp $FILES_DIRECTORY/firefox-policies.json.j2 $1/policies.json
            fi
    fi
}

setsettings /usr/share/firefox/distribution
setsettings /usr/share/firefox-esr/distribution