#!/bin/bash
sudo pacman -Syu wget firefox nodejs tldr lsd flatpak nvidia-settings ncdu btop bash-completion traceroute tree trash-cli cronie vi electron
flatpak install net.brinkervii.grapejuice -y

git clone https://aur.archlinux.org/yay.git ~/yay && cd ~/yay/ && makepkg -si
paru -Syu powerpill appimagelauncher spotify
git clone https://aur.archlinux.org/paleofetch-git.git ~/paleofetch && cd ~/paleofetch/ && makepkg -sif –clean
sudo pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key FBA220DFC880C036
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
sudo sh -c "echo -e '\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist' >> /etc/pacman.conf"
sudo pacman -Sy && sudo powerpill -Su && paru -Su

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
