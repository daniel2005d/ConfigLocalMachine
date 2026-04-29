#!/bin/bash

source functions.sh


echo -e "Run with sudo -E"
echo -e "***************"


# Install Packages
sudo apt install -y \
python3-venv \
sqlmap \
macchanger \
vim \
lsd \
pipx \
git \
tmux \
curl \
openssh-server \
rofi \
grc \
htop \
xclip \
jq \
net-tools \
nmap \
netexec \
isc-dhcp-client \
isc-dhcp-client-ddns \
aircrack-ng \
metasploit-framework \
sqlitebrowser \
ffuf \
exiftool \
hashid \
hashcat \
html2text \
dislocker \
evil-winrm \
freerdp3-x11 \
remmina \
smbclient \
hydra \
dnsx \
crunch \
golang-go \
python3-setuptools \
python3-wheel \
python3-build \
responder \
bettercap \
wireshark \
nginx \
python3-pip \
libpcap-dev \
file \
realmd \
krb5-user \
cherrytree

## Fonts

set_fonts

xfconf-query -c xfce4-keyboard-shortcuts \
    -p "/commands/custom/<Alt>F2" \
    -n -t string -s "rofi -show run"

xfconf-query -c xfce4-keyboard-shortcuts \
    -p "/commands/custom/<Super>Return" \
    -n -t string -s "qterminal"

xfconf-query -c xfce4-keyboard-shortcuts \
    -p "/commands/custom/<Super>d" \
    -n -t string -s "show_desktop_key"

## Custom Settings
cp -r -v files/config/*.xml ~/.config/xfce4/xfconf/xfce-perchannel-xml/

# Cambiar el wallpaper para el monitor actual (ajusta el nombre si es necesario)
#sudo -u "$REAL_USER" DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$USER_ID/bus \
#xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorVirtual1/workspace0/last-image -s "/usr/share/backgrounds/default.png"

#sudo -u "$REAL_USER" DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$USER_ID/bus \
#xfconf-query -c xsettings -p /Net/IconThemeName -s "custom-kali"


cp files/.bashrc ${HOME}/
cp files/.bash_aliases ${HOME}/
cp files/.vimrc ${HOME}/
cp files/.tmux.conf ${HOME}/


## Wallpaper
if [ ! -f "usr/share/backgrounds/wp8828961-offensive-security-wallpapers.png" ]; then
    sudo cp -v files/wallpaper/*.png /usr/share/backgrounds/
fi


## Themes

if [ ! -d "/usr/share/themes/mkos-BigSur-Dark-gtk" ]; then
    sudo cp -r -v files/themes/mkos-BigSur-Dark-gtk /usr/share/themes/
fi

if [ ! -d "/usr/share/themes/Mkosbigsur-gtk" ]; then
    sudo cp -r -v files/themes/Mkosbigsur-gtk /usr/share/themes/
fi

## Icons

if [ ! -d "/usr/share/icons/hackthebox" ]; then
    sudo cp -r -v icons/hackthebox /usr/share/icons/
fi

if [ ! -d "/usr/share/icons/custom-kali" ]; then
    sudo cp -r -v icons/custom-kali /usr/share/icons/
fi

## Allow images to icons
if ! grep -qF "QT_QPA_PLATFORMTHEME=gtk3 qterminal" "/etc/environment"; then
    echo "QT_QPA_PLATFORMTHEME=gtk3 qterminal" | sudo  tee -a "/etc/environment"
else
    print_info "La configuración ya existe, saltando..." $redColour
fi

## Panel Icons
sudo cp -v files/desktop/*.* /usr/share/applications/
cp -v files/desktop/*.* ~/.local/share/applications

sudo cp -v -r icons/*.svg ~/.local/share/icons/hackthebox/icons/

unlock_opt
unlock_sudo
add_scripts

sudo gtk-update-icon-cache -f -t /usr/share/icons/custom-kali/
xfce4-panel-profiles load files/config/custompanel.tar.bz2
xfconf-query -c xsettings -p /Net/IconThemeName -s "custom-kali"
xfconf-query -c xfce4-desktop -p /backdrop -l | grep "last-image" | xargs -I {} xfconf-query -c xfce4-desktop -p {} -s "/usr/share/backgrounds/default.png"
xfconf-query -c xsettings -p /Net/ThemeName -s "Kali-Green-Dark"

## Terminal

cp files/config/qterminal.ini ~/.config/qterminal.org/qterminal.ini

./git.sh