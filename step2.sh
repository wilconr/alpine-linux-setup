#!/bin/ash

apk add curl socat nmap net-tools build-base setxkbmap sudo xrandr bash zsh dbus dbus-x11 xorg-server xf86-input-libinput xinit eudev xfce4 xfce4-terminal lightdm
#apk add open-vm-tools open-vm-tools-guestinfo open-vm-tools-deploypkg open-vm-tools-gtk
apk add lightdm-gtk-greeter i3wm i3status libxcb-dev i3lock xf86-video-vmware dmenu
apk add mesa-gl glib feh firefox-esr accountsservice openvpn
apk add docker docker-compose

# add user
adduser wilmer
mkdir -p /home/wilmer/wallpaper
mkdir -p /home/wilmer/.config/i3

# user setup wilmer
cp ./wilmer/wallpaper/compass.jpg /home/wilmer/wallpaper/compass.jpg
cp ./wilmer/.config/i3/config /home/wilmer/.config/i3/config
cp ./wilmer/.profile /home/wilmer/.profile
mkdir -p /home/wilmer/.scripts
cp ./wilmer/login-script.sh /home/wilmer/.scripts/login-script.sh
chown -R wilmer:wilmer /home/wilmer

# add wilmer to sudoers
cat ./wilmer/sudoers >> /etc/sudoers

# greeter background
echo "background=/home/wilmer/wallpaper/compass.jpg" >> /etc/lightdm/lightdm-gtk-greeter.conf

# set background image in accountsservice
cp ./wilmer/wilmer /var/lib/AccountsService/users
chown root:root /var/lib/AccountsService/users/wilmer

# add user to docker
addgroup wilmer docker

# enable copy paste in vmware
chmod g+s /usr/bin/vmware-user-suid-wrapper

# give wilmer write access to /opt dir
chown wilmer:wilmer /opt

# mkdir /opt/docker
mkdir -p /opt/docker
cp ./docker/* /opt/docker/
chown wilmer:wilmer /opt/docker


