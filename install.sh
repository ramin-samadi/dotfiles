#!/bin/bash

#_____________________________________________________________________________
clear

echo "
░█████╗░██╗░░░██╗██████╗░  ██╗░░██╗███████╗██╗░░░░░██████╗░███████╗██████╗░
██╔══██╗██║░░░██║██╔══██╗  ██║░░██║██╔════╝██║░░░░░██╔══██╗██╔════╝██╔══██╗
███████║██║░░░██║██████╔╝  ███████║█████╗░░██║░░░░░██████╔╝█████╗░░██████╔╝
██╔══██║██║░░░██║██╔══██╗  ██╔══██║██╔══╝░░██║░░░░░██╔═══╝░██╔══╝░░██╔══██╗
██║░░██║╚██████╔╝██║░░██║  ██║░░██║███████╗███████╗██║░░░░░███████╗██║░░██║
╚═╝░░╚═╝░╚═════╝░╚═╝░░╚═╝  ╚═╝░░╚═╝╚══════╝╚══════╝╚═╝░░░░░╚══════╝╚═╝░░╚═╝

paru, yay, pakku, aurutils, trizen, pikaur, aura

Which aur helpers do you want to install? (separate by space, e.g. 'paru yay')
"
read aur_helpers

for aur in $aur_helpers; do
    git clone https://aur.archlinux.org/$aur.git ~/$aur && cd ~/$aur/ && makepkg -sif –clean && clear
done

#_____________________________________________________________________________

echo "
██████╗░██████╗░░█████╗░░██╗░░░░░░░██╗░██████╗███████╗██████╗░
██╔══██╗██╔══██╗██╔══██╗░██║░░██╗░░██║██╔════╝██╔════╝██╔══██╗
██████╦╝██████╔╝██║░░██║░╚██╗████╗██╔╝╚█████╗░█████╗░░██████╔╝
██╔══██╗██╔══██╗██║░░██║░░████╔═████║░░╚═══██╗██╔══╝░░██╔══██╗
██████╦╝██║░░██║╚█████╔╝░░╚██╔╝░╚██╔╝░██████╔╝███████╗██║░░██║
╚═════╝░╚═╝░░╚═╝░╚════╝░░░░╚═╝░░░╚═╝░░╚═════╝░╚══════╝╚═╝░░╚═╝

firefox, librewolf-bin, vivaldi, google-chrome, chromium, epiphany, microsoft-edge-stable-bin, brave-bin, waterfox-classic-bin, qutebrowser, opera, icecat

Which browsers do you want to install? (separate by space, e.g. 'firefox google-chrome')
"
read browsers

for browser in $browsers; do
    $aur -Syu $browser && clear
done

#_____________________________________________________________________________

echo "
████████╗███████╗██████╗░███╗░░░███╗██╗███╗░░██╗░█████╗░██╗░░░░░
╚══██╔══╝██╔════╝██╔══██╗████╗░████║██║████╗░██║██╔══██╗██║░░░░░
░░░██║░░░█████╗░░██████╔╝██╔████╔██║██║██╔██╗██║███████║██║░░░░░
░░░██║░░░██╔══╝░░██╔══██╗██║╚██╔╝██║██║██║╚████║██╔══██║██║░░░░░
░░░██║░░░███████╗██║░░██║██║░╚═╝░██║██║██║░╚███║██║░░██║███████╗
░░░╚═╝░░░╚══════╝╚═╝░░╚═╝╚═╝░░░░░╚═╝╚═╝╚═╝░░╚══╝╚═╝░░╚═╝╚══════╝

st, alacritty, yakuake, terminator, guake, tilda, tilix, terminology, wezterm, xterm, cool-retro-term, gnome-console, gnome-terminal, konsole, xfce4-terminal, lxterminal

Which terminals do you want to install? (separate by space, e.g. 'st alacritty')
"
read terminals

for terminal in $terminals; do
    $aur -Syu $terminal && clear
done

#_____________________________________________________________________________

echo "
███████╗██████╗░██╗████████╗░█████╗░██████╗░
██╔════╝██╔══██╗██║╚══██╔══╝██╔══██╗██╔══██╗
█████╗░░██║░░██║██║░░░██║░░░██║░░██║██████╔╝
██╔══╝░░██║░░██║██║░░░██║░░░██║░░██║██╔══██╗
███████╗██████╔╝██║░░░██║░░░╚█████╔╝██║░░██║
╚══════╝╚═════╝░╚═╝░░░╚═╝░░░░╚════╝░╚═╝░░╚═╝

vi, vim, emacs, neovim, neovim-nightly-bin, nano, visual-studio-code-bin, vscodium-bin, gedit, notepadqq, kate, leafpad, code

Which editors do you want to install? (separate by space, e.g. 'neovim, vscodium-bin')
"
read editors

for editor in $editors; do
    $aur -Syu $editor && clear
done

#_____________________________________________________________________________

echo "
██╗░░░██╗██╗██████╗░████████╗██╗░░░██╗░█████╗░██╗░░░░░██╗███████╗░█████╗░████████╗██╗░█████╗░███╗░░██╗
██║░░░██║██║██╔══██╗╚══██╔══╝██║░░░██║██╔══██╗██║░░░░░██║╚════██║██╔══██╗╚══██╔══╝██║██╔══██╗████╗░██║
╚██╗░██╔╝██║██████╔╝░░░██║░░░██║░░░██║███████║██║░░░░░██║░░███╔═╝███████║░░░██║░░░██║██║░░██║██╔██╗██║
░╚████╔╝░██║██╔══██╗░░░██║░░░██║░░░██║██╔══██║██║░░░░░██║██╔══╝░░██╔══██║░░░██║░░░██║██║░░██║██║╚████║
░░╚██╔╝░░██║██║░░██║░░░██║░░░╚██████╔╝██║░░██║███████╗██║███████╗██║░░██║░░░██║░░░██║╚█████╔╝██║░╚███║
░░░╚═╝░░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░░╚═════╝░╚═╝░░╚═╝╚══════╝╚═╝╚══════╝╚═╝░░╚═╝░░░╚═╝░░░╚═╝░╚════╝░╚═╝░░╚══╝

Which virtualization platforms do you want to install? (virtualbox, vmware, quickemu, qemu)
"
read virtualization && $aur -Syu $virtualization && clear

#_____________________________________________________________________________

echo "
██████╗░░█████╗░░██████╗░██████╗░██╗░░░░░░░██╗░█████╗░██████╗░██████╗░
██╔══██╗██╔══██╗██╔════╝██╔════╝░██║░░██╗░░██║██╔══██╗██╔══██╗██╔══██╗
██████╔╝███████║╚█████╗░╚█████╗░░╚██╗████╗██╔╝██║░░██║██████╔╝██║░░██║
██╔═══╝░██╔══██║░╚═══██╗░╚═══██╗░░████╔═████║░██║░░██║██╔══██╗██║░░██║
██║░░░░░██║░░██║██████╔╝██████╔╝░░╚██╔╝░╚██╔╝░╚█████╔╝██║░░██║██████╔╝
╚═╝░░░░░╚═╝░░╚═╝╚═════╝░╚═════╝░░░░╚═╝░░░╚═╝░░░╚════╝░╚═╝░░╚═╝╚═════╝░

███╗░░░███╗░█████╗░███╗░░██╗░█████╗░░██████╗░███████╗██████╗░
████╗░████║██╔══██╗████╗░██║██╔══██╗██╔════╝░██╔════╝██╔══██╗
██╔████╔██║███████║██╔██╗██║███████║██║░░██╗░█████╗░░██████╔╝
██║╚██╔╝██║██╔══██║██║╚████║██╔══██║██║░░╚██╗██╔══╝░░██╔══██╗
██║░╚═╝░██║██║░░██║██║░╚███║██║░░██║╚██████╔╝███████╗██║░░██║
╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝░░╚══╝╚═╝░░╚═╝░╚═════╝░╚══════╝╚═╝░░╚═╝

pass, keepassxc, bitwarden, lastpass, 1password, seahorse (for 2FA you could install authy)

What password manager do you want to install? () 
"
read password && $aur -Syu $password && clear

#_____________________________________________________________________________

echo "
██████╗░███████╗███╗░░░███╗░█████╗░████████╗███████╗  ██████╗░███████╗░██████╗██╗░░██╗████████╗░█████╗░██████╗░
██╔══██╗██╔════╝████╗░████║██╔══██╗╚══██╔══╝██╔════╝  ██╔══██╗██╔════╝██╔════╝██║░██╔╝╚══██╔══╝██╔══██╗██╔══██╗
██████╔╝█████╗░░██╔████╔██║██║░░██║░░░██║░░░█████╗░░  ██║░░██║█████╗░░╚█████╗░█████═╝░░░░██║░░░██║░░██║██████╔╝
██╔══██╗██╔══╝░░██║╚██╔╝██║██║░░██║░░░██║░░░██╔══╝░░  ██║░░██║██╔══╝░░░╚═══██╗██╔═██╗░░░░██║░░░██║░░██║██╔═══╝░
██║░░██║███████╗██║░╚═╝░██║╚█████╔╝░░░██║░░░███████╗  ██████╔╝███████╗██████╔╝██║░╚██╗░░░██║░░░╚█████╔╝██║░░░░░
╚═╝░░╚═╝╚══════╝╚═╝░░░░░╚═╝░╚════╝░░░░╚═╝░░░╚══════╝  ╚═════╝░╚══════╝╚═════╝░╚═╝░░╚═╝░░░╚═╝░░░░╚════╝░╚═╝░░░░░

x11vnc, rustdesk-bin, teamviewer, anydesk-bin, remmina, parsec-bin, realvnc-vnc-viewer, nomachine

Which remote desktop softwares do you want to install? (separate by space, e.g. 'teamviewer, rustdesk-bin')
"
read remote_desktops

for remote_desktop in $remote_desktops; do
    $aur -Syu $remote_desktop && clear
done

#_____________________________________________________________________________

sudo pacman -Syu gnupg mpg123 python-pip pass pass-otp zbar wget pavucontrol pamixer playerctl unzip xorg nodejs tldr lsd flatpak ncdu btop bash-completion traceroute tree trash-cli cronie vi linux-headers electron cairo gtk3 gobject-introspection desktop-file-utils xdg-utils xdg-user-dirs gtk-update-icon-cache shared-mime-info mesa-utils wine gnutls lib32-gnutls libpulse lib32-libpulse

pip install neovim langdetect shell-gpt --user
cd ~/ && git clone https://aur.archlinux.org/python-gtts.git && cd python-gtts/ && makepkg -sif --clean

$aur -Syu ruby npm yarn pnpm appimagelauncher fd lazygit libguestfs dmidecode virt-manager ebtables iptables virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat powershell-bin w3m xclip openrazer-daemon openrazer-driver-dkms openrazer-meta python-openrazer polychromatic bc ufw fail2ban ngrok jq mpv ueberzug ffmpeg ffmpeg4.4 yt-dlp qemu-full dust ripgrep fzf ranger ueberzug dust nmap whois calcurse rustdesk-bin motrix-bin amdguid-glow-bin vulkan-amdgpu-pro lib32-vulkan-amdgpu-pro
gem install neovim && sudo npm install -g neovim 
sudo gpasswd -a $USER plugdev
sudo systemctl enable --now libvirtd.service && sudo usermod -a -G libvirt $(whoami) && sudo systemctl restart libvirtd.service
git clone https://aur.archlinux.org/paleofetch-git.git ~/paleofetch && cd ~/paleofetch/ && makepkg -sif –clean
cd && git clone https://github.com/pystardust/ytfzf && cd ytfzf && sudo make install doc && sudo make addons

git clone --depth=1 https://gitlab.com/brinkervii/grapejuice.git /tmp/grapejuice && cd /tmp/grapejuice && ./install.py
cd && wget https://github.com/raminsamadi123/hyprinstall/releases/download/Fonts/Meslo-fonts.zip && unzip Meslo-fonts.zip && sudo rm -rf Meslo-fonts.zip
git clone https://github.com/christitustech/mybash ~/mybash && cd ~/mybash/ && ./setup-arch.sh

git clone --recursive https://github.com/akinomyoga/ble.sh.git && make -C ble.sh && source ble.sh/out/ble.sh && make -C ble.sh install PREFIX=~/.local && echo 'source ~/.local/share/blesh/ble.sh' >> ~/.bashrc

sudo sed -i 's/#Color/Color/g' /etc/pacman.conf && sudo sed -i 's/#NoProgressBar/ILoveCandy/g' /etc/pacman.conf && sudo sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 5/g' /etc/pacman.conf

sudo bash -c "echo '58,18 * * * * sudo pacman -Syu --noconfirm && flatpak update -y && paru -Syu' >> /var/spool/cron/root" && sudo systemctl stop cronie && sudo systemctl enable cronie.service && sudo systemctl start cronie.service

git clone https://aur.archlinux.org/st.git ~/bin && cd ~/bin/ && makepkg -sif –clean && cp config.def.h config.h
git clone https://aur.archlinux.org/dwm.git ~/bin/dwm && cd ~/bin/dwm/ && makepkg -sif –clean

sudo rm -rf ~/bin/config.h
mv ~/dwm/config.h ~/bin/
cd ~/bin
makepkg -if --clean

mv -f ~/dwm/dwm/config.h ~/.config/dwm/ && cd ~/.config/dwm/ && makepkg -if --clean
sudo mv -f ~/dwm/.xinitrc ~/.xinitrc
cat ~/dwm/.bashrc >> ~/.bashrc && source ~/.bashrc
sudo mv -f ~/dwm/.bash_profile ~/.bash_profile && source ~/.bash_profile

sudo rm -rf ~/dwm
mv ~/bin/dwm ~/.config/
mv ~/bin ~/.config/st/
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

reboot
