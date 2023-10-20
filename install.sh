#!/bin/bash
source utils.sh

banner(){
    echo -e """
    
░█████╗░░█████╗░███╗░░██╗███████╗██╗░██████╗░
██╔══██╗██╔══██╗████╗░██║██╔════╝██║██╔════╝░
██║░░╚═╝██║░░██║██╔██╗██║█████╗░░██║██║░░██╗░
██║░░██╗██║░░██║██║╚████║██╔══╝░░██║██║░░╚██╗
╚█████╔╝╚█████╔╝██║░╚███║██║░░░░░██║╚██████╔╝
░╚════╝░░╚════╝░╚═╝░░╚══╝╚═╝░░░░░╚═╝░╚═════╝░

$yellowColour Version: 0.4 
Desktop: $XDG_CURRENT_DESKTOP $reset
    """
}

create_config_folders(){
    local_folders=("applications" "icons" "themes" "fonts")
    for folder in "${local_folders[@]}";
    do
        dir=$LOCAL_FOLDER/$folder
      if [ ! -d  $dir ];
        then
            print_info "Creating Folder $dir"
            mkdir $dir
        fi
    done
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

config_terminal(){
    
    if [ -d "$FILES_DIRECTORY" ];
        print_info "Setting terminal"
        then
            for file in "$FILES_DIRECTORY"/.*;
            do
                if [ -f $file ] && [ ! -L $file ];
                then
                    /usr/bin/cp  $file $HOME 
                fi
            done
        fi
}

config_desktop(){
    if command -v "dconf" &>/dev/null;
    then
        /usr/bin/cp $FILES_DIRECTORY/mate.settings.j2 /tmp/mate.settings.j2
        /usr/bin/sed -i "s|custom_HOME|$HOME|g" /tmp/mate.settings.j2
        /usr/bin/dconf load / < /tmp/mate.settings.j2 
    fi
}

terminal_icons(){
    print_info "[+] Copy Environment Icons $TERMINAL_ICON"
    icons_folder=("/hackthebox/icons" "/hackthebox/22/apps" "/hackthebox/32/apps"
      "/hackthebox/64/apps"
      "/hackthebox/24x24/apps")
    
  
    for icon in "${icons_folder[@]}";
    do 
        create_if_notexists $LOCAL_FOLDER/icons/$icon
        if [ ! -d $LOCAL_FOLDER/icons/$icon ];
        then
            /usr/bin/cp $TERMINAL_ICON $LOCAL_FOLDER/icons/$icon/utilities-terminal.svg
        fi
    done

    if [ -d $GLOBAL_ICONS_FOLDER/hackthebox ];
    then
        print_info "[+] Custom toolbar Icons"
        sudo /usr/bin/cp $ICONS_DIRECTORY/* $GLOBAL_ICONS_FOLDER/hackthebox/64/apps/
    fi
    
}

set_terminaldesktop(){
    /usr/bin/cp "$FILES_DIRECTORY/mate-terminal.desktop" /tmp/mate-terminal.desktop
    replace_homefolder "/tmp/mate-terminal.desktop"
    /usr/bin/cp /tmp/mate-terminal.desktop "$LOCAL_FOLDER/applications/mate-terminal.desktop"
}

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

change_grubdelay(){
    if [ -f $GRUB ];
    then
        sudo sed -i 's/TIMEOUT=.*/TIMEOUT=1/g' $GRUB
        if [ $? -eq 0 ];
        then
            sudo /usr/sbin/update-grub &>/dev/null
        fi
    fi
}

setxfcpanel(){
    
    if [ "$XDG_CURRENT_DESKTOP" = "XFCE" ];
    then
        print_info $greenColour "Setting XFCE Panels" $reset
        cp -rv $(pwd)/desktop/xfce/panel/* $HOME/.config/xfce4/panel/
    fi
}

banner
unlock_sudo
unlock_opt
create_config_folders
config_terminal
terminal_icons
set_fonts
change_grubdelay
add_scripts
config_desktop
set_terminaldesktop
setxfcpanel
./install_packages.sh