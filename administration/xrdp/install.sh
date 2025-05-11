sudo apt-get -y install xrdp
sudo reboot now
echo xfce4-session >~/.xsession
sudo service xrdp restart

### Gnome on ubuntu
# Install xrdp and gnome-session:
sudo apt install xrdp gnome-session
# Allow log in after xrdp setup:
sudo adduser xrdp ssl-cert
# Specify Gnome for your remote session:
echo "gnome-session" | tee ~/.xsession
# Then set your ~/.xsessionrc file using:
echo "export XAUTHORITY=${HOME}/.Xauthority" | tee ~/.xsessionrc
echo "export GNOME_SHELL_SESSION_MODE=ubuntu" | tee -a ~/.xsessionrc
echo "export XDG_CONFIG_DIRS=/etc/xdg/xdg-ubuntu:/etc/xdg" | tee -a ~/.xsessionrc
echo "export XDG_CURRENT_DESKTOP=ubuntu:GNOME" | tee -a ~/.xsessionrc
sudo systemctl restart xrdp