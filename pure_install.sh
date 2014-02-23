
echo -e "\nThis installer offers two packages to provide flash support: \n\t[1] Gnash (GNU)\n\n\t[2] Adobe Flash Plugin (non-free)\n\n"  
read -p "Choose an option [1]:" flash_op
read -p "Do you want to install OpenJDK 7 ( Java 7 support ) ? [Y/n]:" java_op
read -p "Do you want to configure any user account? [Y/n]:" conf_op
[ "$conf_op" == "n" ] || [ "$conf_op" == "N" ] || read -p "Enter user account name to configure: " username


aptitude update
aptitude upgrade -y
aptitude update
aptitude install -y sudo xfce4-terminal


aptitude update
aptitude install -y build-essential pkg-config checkinstall openbox openbox-themes dmz-cursor-theme xorg gnome-themes gnome-icon-theme gnome-icon-theme-extras python-xdg xdg-utils

aptitude update

mkdir -p /usr/share/images/custom-greeter
mv ./pure_greeter.jpg /usr/share/images/custom-greeter/

#Setting up sound
aptitude install -y libasound2 libasound2-doc libasound2-plugins alsa-base alsa-utils alsa-oss pulseaudio pavucontrol paprefs
aptitude update

#Install session manager
aptitude install -y lightdm

#/usr/lib/i386-linux-gnu/lightdm/lightdm-set-defaults -s openbox
sed -i '/greeter-hide-users/c\greeter-hide-users=true' /etc/lightdm/lightdm.conf
#Set greeter wallpaper
sed -i '/^background/c\background=/usr/share/images/custom-greeter/pure_greeter.jpg' /etc/lightdm/lightdm-gtk-greeter.conf
sed -i '/user-session/c\user-session=openbox' /etc/lightdm/lightdm.conf

#Java install 
[ "$java_op" == "n" ] || [ "$java_op" == "N" ] || aptitude install -y openjdk-7-jdk

#Setting up general utilities
aptitude install -y synapse vim git maven lxappearance thunar thunar-volman tint2 conky-all lxinput lxrandr arandr python-statgrab ttf-droid curl lm-sensors hddtemp file-roller zip unzip feh gthumb imagemagick evince vlc banshee leafpad brasero calibre libreoffice baobab gnome-screenshot gnome-disk-utility gnome-themes-extras 

case "$flash_op" in

    2)
        #Install flashplugin (nonfree)
        echo 'deb ftp://ftp.debian.org/debian stable main contrib non-free' >> /etc/apt/sources.list
        aptitude update
        aptitude install -y flashplugin-nonfree flashplugin-nonfree-extrasound
        ;;
    *)
        #Install Gnash flash support
        aptitude install -y gnash browser-plugin-gnash 
        aptitude update
        ;;
esac

#Install Web browser & Mail client
aptitude install -y iceweasel icedove
aptitude update

#Changing greeter UI
mv ./pure_greeter.ui /usr/share/lightdm-gtk-greeter/greeter.ui

#Installing compton
aptitude install -y libxcomposite-dev libxdamage-dev libxrender-dev libxrandr-dev libxinerama-dev libconfig-dev libdbus-1-dev libgl1-mesa-dev libdrm-dev libpcre3-dev libglu-dev x11proto-gl-dev libx11-dev libxfixes-dev libxfixes3 libxext-dev libxext6 asciidoc
cd /tmp
git clone https://github.com/chjj/compton.git
cd compton
make
make docs
make install
cd

echo -e "CONFIGURING SENSORS\n"
sensors-detect
/etc/init.d/module-init-tools start
chmod u+s /usr/sbin/hddtemp

#Installing conky-colors
wget -O conky_colors.zip https://www.dropbox.com/s/wl7q5ttsp61zfwy/conky_colors.zip
unzip conky_colors.zip 
cd conky_colors
make
make install
cd ..


if [[ -n "$username" ]]; then

    usermod -aG sudo $username
    echo -e "$username\tALL=(root)\tNOPASSWD:\t/sbin/reboot, /sbin/shutdown, /sbin/halt, /sbin/restart\n" >> /etc/sudoers
    mv ./pure_conf.sh /home/$username/
    mv ./pure_menu.xml /home/$username/
    mv ./pure_rc.xml /home/$username/
    mv ./vim_conf.zip /home/$username/
    mkdir -p /home/$username/Pictures/Wallpapers
    mv ./pure_wallpaper.jpg /home/$username/Pictures/Wallpapers
    chown $username /home/$username/Pictures/Wallpapers/pure_wallpaper.jpg
    chmod 777 /home/$username/pure_conf.sh
    chmod 777 /home/$username/pure_menu.xml
    chmod 777 /home/$username/pure_rc.xml
    chmod 777 /home/$username/vim_conf.zip

    #Creating filestructure for user config
    su $username -c '/home/'$username'/pure_conf.sh '$username -l 

    #Cleaning files
    rm -f /home/$username/pure_conf.sh /home/$username/pure_menu.xml /home/$username/pure_rc.xml 

fi


#Installing obmenu
aptitude update
aptitude install -y obmenu
update-mime-database /usr/share/mime
update-desktop-database /usr/share/applications

#Installing network manager
aptitude update
aptitude install -y network-manager network-manager-gnome

sudo reboot
