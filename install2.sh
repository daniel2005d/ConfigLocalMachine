#!/bin/bash

source functions.sh


echo -e "Run with sudo -E"
echo -e "***************"

if [ "$EUID" -ne 0 ]; then 
  echo "Please run with sudo"
  exit 1
fi

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
xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorVirtual1/workspace0/last-image -s "/usr/share/backgrounds/default.png"
xfconf-query -c xsettings -p /Net/IconThemeName -s "custom-kali"


cp files/.bashrc ${HOME}/
cp files/.bash_aliases ${HOME}/
cp files/.vimrc ${HOME}/
cp files/.tmux.conf ${HOME}/


## Wallpaper
if [ ! -f "usr/share/backgrounds/wp8828961-offensive-security-wallpapers.png" ]; then
    cp -v files/wallpaper/*.png /usr/share/backgrounds/
fi


## Themes

if [ ! -d "/usr/share/themes/mkos-BigSur-Dark-gtk" ]; then
    cp -r -v files/themes/mkos-BigSur-Dark-gtk /usr/share/themes/
fi

if [ ! -d "/usr/share/themes/Mkosbigsur-gtk" ]; then
    cp -r -v files/themes/Mkosbigsur-gtk /usr/share/themes/
fi

## Icons

if [ ! -d "/usr/share/icons/hackthebox" ]; then
    cp -r -v icons/hackthebox /usr/share/icons/
fi

if [ ! -d "/usr/share/icons/custom-kali" ]; then
    cp -r -v icons/custom-kali /usr/share/icons/
fi

## Allow images to icons
if ! grep -qF "QT_QPA_PLATFORMTHEME=gtk3 qterminal" "/etc/environment"; then
    echo "QT_QPA_PLATFORMTHEME=gtk3 qterminal" | tee -a "/etc/environment"
else
    print_info "La configuración ya existe, saltando..." $redColour
fi

## Panel Icons
cp -v files/icons/*.* /usr/share/applications/

unlock_opt
unlock_sudo
add_scripts


gtk-update-icon-cache -f -t /usr/share/icons/custom-kali/