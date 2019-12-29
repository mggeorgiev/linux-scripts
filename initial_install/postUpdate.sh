#!/bin/bash
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'
gsettings set org.gnome.desktop.interface show-battery-percentage true
#echo 'export HISTTIMEFORMAT="%d/%m/%y %T "' >> ~/.bash_profile
echo 'export HISTTIMEFORMAT="%F %T: "' >> ~/.bash_profile
source ~/.bash_profile
