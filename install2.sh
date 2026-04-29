#!/bin/bash

source functions.sh
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
cp -r -v files/*.xml ${HOME}/.config/xfce4/xfconf/xfce-perchannel-xml/


cp files/.bashrc ${HOME}/
cp files/.bash_aliases ${HOME}/
cp files/.vimrc ${HOME}/
cp files/.tmux ${HOME}/


## Wallpaper

mkdir /usr/share/backgrounds/${USER}
cp -v files/wallpaper/*.png /usr/share/backgrounds/${USER}

## Icons

cp -r -v files/icons/hackthebox /usr/share/icons/

## Allow images to icons

echo "QT_QPA_PLATFORMTHEME=gtk3 qterminal" >> /etc/environment


unlock_opt
unlock_sudo