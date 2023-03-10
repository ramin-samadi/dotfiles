#!/bin/bash
sudo pacman -Syu gnupg mpg123 python-pip pass pass-otp zbar wget pavucontrol pamixer playerctl firefox unzip xorg nodejs tldr lsd flatpak ncdu btop bash-completion traceroute tree trash-cli cronie vi linux-headers electron cairo gtk3 gobject-introspection desktop-file-utils xdg-utils xdg-user-dirs gtk-update-icon-cache shared-mime-info mesa-utils wine gnutls lib32-gnutls libpulse lib32-libpulse
pip install langdetect shell-gpt --user
cd ~/ && git clone https://aur.archlinux.org/python-gtts.git && cd python-gtts/ && makepkg -sif --clean

git clone https://aur.archlinux.org/paru.git ~/paru && cd ~/paru/ && makepkg -sif –clean
git clone https://aur.archlinux.org/yay.git ~/yay && cd ~/yay/ && makepkg -sif –clean
paru -Syu appimagelauncher powershell-bin neovim-nightly-bin w3m xclip openrazer-daemon openrazer-driver-dkms openrazer-meta python-openrazer polychromatic bc ufw fail2ban ngrok x11vnc jq mpv ueberzug ffmpeg ffmpeg4.4 yt-dlp qemu-full dust ripgrep fzf ranger ueberzug dust bitwarden authy nmap whois calcurse rustdesk-bin motrix-bin amdguid-glow-bin vulkan-amdgpu-pro lib32-vulkan-amdgpu-pro
sudo gpasswd -a $USER plugdev
git clone https://aur.archlinux.org/paleofetch-git.git ~/paleofetch && cd ~/paleofetch/ && makepkg -sif –clean
git clone https://github.com/pystardust/ytfzf
cd && cd ytfzf
sudo make install doc
sudo make addons

git clone --depth=1 https://gitlab.com/brinkervii/grapejuice.git /tmp/grapejuice
cd /tmp/grapejuice
./install.py

cd && wget https://github.com/raminsamadi123/hyprinstall/releases/download/Fonts/Meslo-fonts.zip
unzip Meslo-fonts.zip
sudo rm -rf Meslo-fonts.zip
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

sudo bash -c "echo '58,18 * * * * sudo pacman -Syu --noconfirm && flatpak update -y && paru -Syu' >> /var/spool/cron/root"
sudo systemctl stop cronie && sudo systemctl enable cronie.service && sudo systemctl start cronie.service

git clone https://aur.archlinux.org/st.git ~/bin && cd ~/bin/ && makepkg -sif –clean && cp config.def.h config.h
git clone https://aur.archlinux.org/dwm.git ~/bin/dwm && cd ~/bin/dwm/ && makepkg -sif –clean

sudo rm -rf ~/bin/config.h
mv ~/dwm/config.h ~/bin/
cd ~/bin
makepkg -if --clean

sudo rm -rf ~/dwm
mv ~/bin/dwm ~/.config/
mv ~/bin ~/.config/st/
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

mv ~/dwm/dwm-config.h ~/.config/dwm/config.h && cd ~/.config/dwm/ && makepkg -if --clean
sudo mv -f ~/dwm/.xinitrc ~/.xinitrc
cat ~/dwm/.bashrc >> ~/.bashrc && source ~/.bashrc
sudo mv -f ~/dwm/.bash_profile ~/.bash_profile && source ~/.bash_profile
