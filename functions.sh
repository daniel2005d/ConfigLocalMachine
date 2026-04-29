source utils.sh

FONTS_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Hack.zip"
LOCAL_FOLDER=$HOME/.local/share

set_fonts(){
    if [ ! -f $LOCAL_FOLDER/fonts/HackNerdFontMono-Regular.ttf ];
    then
        if [ -d $LOCAL_FOLDER/fonts ];
        then
            print_info "Downloading Hack Nerd Fonts"
            /usr/bin/wget $FONTS_URL -O /tmp/hack.zip
            if [ -f /tmp/hack.zip ];
            then
                print_info "Inflating Fonts"    
                /usr/bin/unzip /tmp/hack.zip -d $LOCAL_FOLDER/fonts/ &>/dev/null
            fi
        fi
    fi
}

unlock_opt(){
    sudo chown -R $USER:$USER /opt
}

unlock_sudo(){
    if ! sudo grep -q "$USER ALL=(ALL) NOPASSWD:ALL" /etc/sudoers;
    then
        print_info "Setting sudoers settings"
        echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers &>/dev/null
    fi
    
}

add_scripts(){
    if [ ! -d $HOME/bin ];
    then
        /usr/bin/mkdir $HOME/bin
    fi

    if [ -d $HOME/bin ];
    then
        print_info "[+] Creating Scripts files"
        /usr/bin/cp $SCRIPTS_DIRECTORY/* $HOME/bin/
    fi
}

