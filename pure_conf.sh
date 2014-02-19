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
echo '(sleep 2s && conky -c /home/alejandro/.conkycolors/conkyrc) &' >> ~/.config/openbox/autostart

cat /home/alejandro/pure_menu.xml > /home/alejandro/.config/openbox/menu.xml
cat /home/alejandro/pure_rc.xml > /home/alejandro/.config/openbox/rc.xml

#Set default wallpaper
touch /home/alejandro/.fehbg
echo "feh --bg-fill '/home/alejandro/Pictures/Wallpapers/pure_wallpaper.jpg'" > /home/alejandro/.fehbg

unzip vim_conf.zip -d ~/.vim
rm -f vim_conf.zip

#Setting up default theme
mkdir -p /home/alejandro/.themes
wget -O /home/alejandro/.themes/1977_themes.tar.gz https://www.dropbox.com/s/ic0pzb2xt7yngl8/1977_themes.tar.gz 
tar xvf /home/alejandro/.themes/1977_themes.tar.gz -C /home/alejandro/.themes/
rm -f /home/alejandro/.themes/1977_themes.tar.gz

wget -O /home/alejandro/.vimrc https://www.dropbox.com/s/1xpm0ojhz6omp59/.vimrc
wget -O /home/alejandro/.bashrc https://www.dropbox.com/s/nrtwa6rd1x4vic6/.bashrc



