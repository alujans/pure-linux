
aptitude update
aptitude upgrade -y
aptitude update
aptitude install -y sudo xfce4-terminal
usermod -aG sudo alejandro

echo -e 'alejandro\tALL=(root)\tNOPASSWD:\t/sbin/reboot, /sbin/shutdown, /sbin/halt, /sbin/restart' >> /etc/sudoers
echo 'deb ftp://ftp.debian.org/debian stable main contrib non-free' >> /etc/apt/sources.list

aptitude update
aptitude install -y build-essential pkg-config checkinstall openbox openbox-themes dmz-cursor-theme xorg gnome-themes gnome-icon-theme gnome-icon-theme-extras python-xdg xdg-utils

aptitude update

#Set up transparency and compositing
#aptitude install -y xcompmgr x11-apps 
#mv xcompmgr_openbox /usr/bin/
#chmod 755 /usr/bin/xcompmgr_openbox
rm -f xcompmgr_openbox

mv ./pure_conf.sh /home/alejandro/
mv ./pure_menu.xml /home/alejandro/
mv ./pure_rc.xml /home/alejandro/
mv ./vim_conf.zip /home/alejandro/
mkdir -p /home/alejandro/Pictures/Wallpapers
mv ./pure_wallpaper.jpg /home/alejandro/Pictures/Wallpapers
chown alejandro /home/alejandro/Pictures/Wallpapers/pure_wallpaper.jpg


chmod 777 /home/alejandro/pure_conf.sh
chmod 777 /home/alejandro/pure_menu.xml
chmod 777 /home/alejandro/pure_rc.xml
chmod 777 /home/alejandro/vim_conf.zip

#Setting up sound
aptitude install -y libasound2 libasound2-doc libasound2-plugins alsa-base alsa-utils alsa-oss pulseaudio pavucontrol paprefs
aptitude update

#Install session manager
aptitude install -y lightdm
/usr/lib/i386-linux-gnu/lightdm/lightdm-set-defaults -s openbox
#sed -i 's/#user-session=default/user-session=openbox/g' /etc/lightdm/lightdm.conf

#Java install 
aptitude install -y openjdk-7-jdk

#Setting up general utilities
aptitude install -y synapse vim git maven lxappearance thunar thunar-volman tint2 conky-all lxinput lxrandr arandr python-statgrab ttf-droid curl lm-sensors hddtemp file-roller zip unzip flashplugin-nonfree feh gthumb imagemagick evince vlc banshee leafpad brasero flashplugin-nonfree-extrasound calibre libreoffice baobab gnome-screenshot
aptitude update

aptitude install -y iceweasel icedove
aptitude update

#Installing compton
aptitude install -y libxcomposite-dev libxdamage-dev libxrender-dev libxrandr-dev libxinerama-dev libconfig-dev libdbus-1-dev libgl1-mesa-dev libdrm-dev libpcre3-dev libglu-dev x11proto-gl-dev libx11-dev libxfixes-dev libxfixes3 libxext-dev libxext6 asciidoc

cd /tmp
git clone https://github.com/chjj/compton.git
cd compton
make
make docs
make install
cd

#Installing spotify
#echo "deb http://repository.spotify.com stable non-free" >> /etc/apt/sources.list
#apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 94558F59
#aptitude update
#aptitude install -y spotify-client

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

#Creating filestructure
su alejandro -c '/home/alejandro/pure_conf.sh' -l 

rm -f install.tar.gz /home/alejandro/pure_conf.sh /home/alejandro/pure_menu.xml /home/alejandro/pure_rc.xml 

#OBMENU
aptitude update
aptitude install -y obmenu
update-mime-database /usr/share/mime
update-desktop-database /usr/share/applications

#Installing network manager
aptitude update
aptitude install -y network-manager network-manager-gnome

sudo reboot