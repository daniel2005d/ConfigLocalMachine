if [ "$XDG_CURRENT_DESKTOP" = "XFCE" ];
    then
        print_info $greenColour "Setting XFCE ShortCuts" $reset
        xfconf-query --create -c xfce4-keyboard-shortcuts -p '/commands/custom/<Super>Return' -t string -s qterminal
        xfconf-query --create -c xfce4-keyboard-shortcuts -p '/commands/custom/<Alt>F2' -t string -s "rofi -show run"
        xfconf-query --create -c xfce4-keyboard-shortcuts -p '/commands/custom/<Super>e' -t string -s "thunar"
    fi

