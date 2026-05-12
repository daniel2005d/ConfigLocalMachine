#!/bin/bash

# 1. Add the signing key
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo tee /etc/apt/trusted.gpg.d/google.asc >/dev/null

# 2. Add the repository to your system
echo "deb http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/chrome.list

# 3. Update package list and install Chrome
sudo apt update
sudo apt install google-chrome-stable
