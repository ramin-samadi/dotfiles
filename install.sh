#!/bin/bash

aur=paru
git clone https://aur.archlinux.org/paru-bin.git ~/.config/paru && cd ~/.config/paru/ && makepkg -sif –clean

$aur -Syu --needed - < ~/dwm/packages.txt
    
pip install neovim langdetect shell-gpt --user

gem install neovim && sudo npm install -g neovim 
sudo gpasswd -a $USER plugdev
sudo systemctl enable --now libvirtd.service && sudo usermod -a -G libvirt $(whoami) && sudo systemctl restart libvirtd.service
sudo virsh net-start default
sudo virsh net-autostart default
sudo systemctl restart libvirtd.service

git clone --depth=1 https://gitlab.com/brinkervii/grapejuice.git /tmp/grapejuice && cd /tmp/grapejuice && ./install.py
cd && wget https://github.com/raminsamadi123/hyprinstall/releases/download/Fonts/Meslo-fonts.zip && unzip Meslo-fonts.zip && sudo rm -rf Meslo-fonts.zip
git clone https://github.com/christitustech/mybash ~/mybash && cd ~/mybash/ && ./setup-arch.sh
sudo pacman -Syu --needed lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader
sudo ufw enable && sudo systemctl enable --now ufw.service

cd
git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git
make -C ble.sh install PREFIX=~/.local
echo 'source ~/.local/share/blesh/ble.sh' >> ~/.bashrc

sudo sed -i 's/#Color/Color/g' /etc/pacman.conf && sudo sed -i 's/#NoProgressBar/ILoveCandy/g' /etc/pacman.conf && sudo sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 5/g' /etc/pacman.conf
sudo sed -i 's/ls -Fls/lsd -Fla/g' ~/.bashrc && sudo sed -i 's/ls -aFh/lsd -aFh/g' ~/.bashrc && sed -i 's,/usr/bin/grep $GREP_OPTIONS,grep --color,g' ~/.bashrc
    
mkdir ~/GitHub
git clone https://github.com/raminsamadi123/dwm ~/GitHub/
git clone https://github.com/raminsamadi123/Programming ~/GitHub/

git clone https://aur.archlinux.org/dwm.git ~/.config/dwm && cd ~/.config/dwm/ && makepkg -sif –clean

git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git
    
mv -f ~/dwm/home/.config/dwm/config.h ~/.config/dwm/ && cd ~/.config/dwm/ && makepkg -sif --clean
mv -f ~/dwm/home/.local/bin/* ~/.local/bin/
mv -f ~/dwm/home/.bashrc ~/
mv -f ~/dwm/home/.bash_profile ~/
mv -f ~/dwm/home/.xinitrc ~/
sudo rm -rf ~/.bashrc.bak
cd
    
sudo bash -c "echo '58,18 * * * * sudo pacman -Syu --noconfirm && flatpak update -y && paru -Syu && yes J | sudo pacman -Scc' >> /var/spool/cron/root" && sudo systemctl stop cronie && sudo systemctl enable cronie.service && sudo systemctl start cronie.service
sudo bash -c "echo '58,18 * * * * /home/ramin/.local/bin/update-dwm' >> /var/spool/cron/$USER" && systemctl stop cronie && systemctl enable cronie.service && systemctl start cronie.service

source ~/.bashrc
source ~/.bash_profile

reboot
