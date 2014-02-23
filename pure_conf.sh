
username=$1

mkdir -p ~/.config/openbox
cp -R /etc/xdg/openbox/* ~/.config/openbox

conky-colors --cpu=4 --debian --clock=modern --theme=blue --calendar --banshee=default --cputemp --battery --updates --hd=default --unit=C --network --swap

sed -i 's/^own_window_type/c\own_window_type desktop' ~/.conkycolors/conkyrc

#echo 'xcompmgr_openbox --startstop &' >> ~/.config/openbox/autostart
echo 'eval `cat $HOME/.fehbg` &' >> ~/.config/openbox/autostart
echo 'thunar --daemon &' >> ~/.config/openbox/autostart
echo 'tint2 &' >> ~/.config/openbox/autostart
echo 'synapse &' >> ~/.config/openbox/autostart
echo '(sleep 1s && compton -CGb) &' >> ~/.config/openbox/autostart
echo "(sleep 2s && conky -c /home/$username/.conkycolors/conkyrc) &" >> ~/.config/openbox/autostart

cat /home/$username/pure_menu.xml > /home/$username/.config/openbox/menu.xml
cat /home/$username/pure_rc.xml > /home/$username/.config/openbox/rc.xml

#Set default wallpaper
touch /home/$username/.fehbg
echo "feh --bg-fill '/home/$username/Pictures/Wallpapers/pure_wallpaper.jpg'" > /home/$username/.fehbg

unzip vim_conf.zip -d ~/.vim
rm -f vim_conf.zip

#Setting up default theme
mkdir -p /home/$username/.themes
wget -O /home/$username/.themes/1977_themes.tar.gz https://www.dropbox.com/s/ic0pzb2xt7yngl8/1977_themes.tar.gz 
tar xvf /home/$username/.themes/1977_themes.tar.gz -C /home/$username/.themes/
rm -f /home/$username/.themes/1977_themes.tar.gz

wget -O /home/$username/.vimrc https://www.dropbox.com/s/1xpm0ojhz6omp59/.vimrc
wget -O /home/$username/.bashrc https://www.dropbox.com/s/nrtwa6rd1x4vic6/.bashrc



