#!/bin/bash
sudo pacman -Syu wget git pamixer firefox unzip vim xorg nodejs tldr lsd flatpak nvidia-settings ncdu btop bash-completion traceroute tree trash-cli cronie vi linux-headers electron
flatpak install net.brinkervii.grapejuice -y

git clone https://aur.archlinux.org/paru.git ~/paru && cd ~/paru/ && makepkg -sif –clean
git clone https://aur.archlinux.org/yay.git ~/yay && cd ~/yay/ && makepkg -sif –clean
paru -Syu powerpill appimagelauncher spotify
git clone https://aur.archlinux.org/paleofetch-git.git ~/paleofetch && cd ~/paleofetch/ && makepkg -sif –clean
sudo pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key FBA220DFC880C036
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
sudo sh -c "echo -e '\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist' >> /etc/pacman.conf"
sudo pacman -Sy && sudo powerpill -Su && paru -Su

cd && wget https://github.com/raminsamadi123/hyprinstall/releases/download/Fonts/Meslo-fonts.zip
unzip Meslo-fonts.zip
git clone https://github.com/christitustech/mybash ~/mybash
cd ~/mybash/
./setup-arch.sh

git clone --recursive https://github.com/akinomyoga/ble.sh.git
make -C ble.sh
source ble.sh/out/ble.sh
make -C ble.sh install PREFIX=~/.local
echo 'source ~/.local/share/blesh/ble.sh' >> ~/.bashrc

sudo sed -i 's/#Color/Color/g' /etc/pacman.conf
sudo sed -i 's/#NoProgressBar/ILoveCandy/g' /etc/pacman.conf
sudo sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 5/g' /etc/pacman.conf

echo "
#Easy Aliases
alias update='sudo pacman -Syu --noconfirm && flatpak update -y && paru -Syu'
alias install='sudo pacman -Syu'
alias search='sudo pacman -Ss'
alias uninstall='sudo pacman -Rns --noconfirm'
alias cls='clear'
alias clean='sudo pacman -Scc'
alias explain='tldr'
alias packages='sudo pacman -Qe'
alias aur='sudo pacman -U'
alias clone='git clone'
alias bat='cat'
alias bios='systemctl reboot --firmware-setup'
bind -x '\"\\C-l\": \"clear; paleofetch\"'
paleofetch
" >> ~/.bashrc && source ~/.bashrc

sudo bash -c "echo '58,18 * * * * sudo pacman -Syu --noconfirm && flatpak update -y && paru -Syu' >> /var/spool/cron/root"
sudo systemctl stop cronie && sudo systemctl enable cronie.service && sudo systemctl start cronie.service

git clone https://aur.archlinux.org/st.git ~/bin && cd ~/bin/ && makepkg -sif –clean && cp config.def.h config.h
git clone https://aur.archlinux.org/dwm.git ~/bin/dwm && cd ~/bin/dwm/ && makepkg -sif –clean

echo '
#!/bin/sh
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

setxkbmap se &

# Login Loop
while true; do
        dwm >/dev/null 2>&1
done

# Start DWM
exec dwm
' > ~/.xinitrc

echo '
#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
startx
' > ~/.bash_profile && source ~/.bash_profile
