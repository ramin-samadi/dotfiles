#!/bin/bash

#_____________________________________________________________________________
git clone https://aur.archlinux.org/smenu.git ~/smenu && cd ~/smenu/ && makepkg -sif –clean && clear

echo -e "\e[32m
░█████╗░██╗░░░██╗██████╗░  ██╗░░██╗███████╗██╗░░░░░██████╗░███████╗██████╗░
██╔══██╗██║░░░██║██╔══██╗  ██║░░██║██╔════╝██║░░░░░██╔══██╗██╔════╝██╔══██╗
███████║██║░░░██║██████╔╝  ███████║█████╗░░██║░░░░░██████╔╝█████╗░░██████╔╝
██╔══██║██║░░░██║██╔══██╗  ██╔══██║██╔══╝░░██║░░░░░██╔═══╝░██╔══╝░░██╔══██╗
██║░░██║╚██████╔╝██║░░██║  ██║░░██║███████╗███████╗██║░░░░░███████╗██║░░██║
╚═╝░░╚═╝░╚═════╝░╚═╝░░╚═╝  ╚═╝░░╚═╝╚══════╝╚══════╝╚═╝░░░░░╚══════╝╚═╝░░╚═╝

Which aur helpers do you want to install?
\e[0m"
# Define the initial list of remote desktop software options
options=(paru yay pakku aurutils trizen pikaur aura)

# Initialize an empty array to store the selected options
selected_options=()

while true; do
    # Add the "Done" option to the beginning of the options array
    remaining_options=("Next" "${options[@]}")

    # Remove any previously selected options from the options array
    for selected in "${selected_options[@]}"; do
        remaining_options=("${remaining_options[@]/$selected}")
    done

    # Prompt the user to select an option from the remaining options
    selected=$(printf "%s\n" "${remaining_options[@]}" | smenu -c -N "Select which aur helper to install:")

    # Exit the loop if the user selects the "Done" option
    if [ "$selected" == "Next" ]; then
        break
    fi

    # Add the selected option to the selected_options array
    selected_options+=("$selected")
done

# Install the selected remote desktop software
for option in "${selected_options[@]}"; do
    git clone https://aur.archlinux.org/$option.git ~/$option && cd ~/$option/ && makepkg -sif –clean && clear
done

install() {
    options=("$@") # Set options array to be the list of arguments passed to the function
    selected_options=()

    while true; do
        # Add the "Done" option to the beginning of the options array
        remaining_options=("Next" "${options[@]}")

        # Remove any previously selected options from the options array
        for selected in "${selected_options[@]}"; do
            remaining_options=("${remaining_options[@]/$selected}")
        done

        # Prompt the user to select an option from the remaining options
        selected=$(printf "%s\n" "${remaining_options[@]}" | smenu -c -N "Select which to install:")

        # Exit the loop if the user selects the "Done" option
        if [ "$selected" == "Next" ]; then
            break
        fi

        # Add the selected option to the selected_options array
        selected_options+=("$selected")
    done

    # Install the selected remote desktop software
    for option in "${selected_options[@]}"; do
        $aur -Syu "$option" && clear
    done
}

#_____________________________________________________________________________

echo -e "\e[32m
██████╗░██████╗░░█████╗░░██╗░░░░░░░██╗░██████╗███████╗██████╗░
██╔══██╗██╔══██╗██╔══██╗░██║░░██╗░░██║██╔════╝██╔════╝██╔══██╗
██████╦╝██████╔╝██║░░██║░╚██╗████╗██╔╝╚█████╗░█████╗░░██████╔╝
██╔══██╗██╔══██╗██║░░██║░░████╔═████║░░╚═══██╗██╔══╝░░██╔══██╗
██████╦╝██║░░██║╚█████╔╝░░╚██╔╝░╚██╔╝░██████╔╝███████╗██║░░██║
╚═════╝░╚═╝░░╚═╝░╚════╝░░░░╚═╝░░░╚═╝░░╚═════╝░╚══════╝╚═╝░░╚═╝

Which browsers do you want to install?
\e[0m"
install firefox librewolf-bin vivaldi google-chrome chromium epiphany microsoft-edge-stable-bin brave-bin waterfox-classic-bin qutebrowser opera icecat

#_____________________________________________________________________________

echo -e "\e[32m
████████╗███████╗██████╗░███╗░░░███╗██╗███╗░░██╗░█████╗░██╗░░░░░
╚══██╔══╝██╔════╝██╔══██╗████╗░████║██║████╗░██║██╔══██╗██║░░░░░
░░░██║░░░█████╗░░██████╔╝██╔████╔██║██║██╔██╗██║███████║██║░░░░░
░░░██║░░░██╔══╝░░██╔══██╗██║╚██╔╝██║██║██║╚████║██╔══██║██║░░░░░
░░░██║░░░███████╗██║░░██║██║░╚═╝░██║██║██║░╚███║██║░░██║███████╗
░░░╚═╝░░░╚══════╝╚═╝░░╚═╝╚═╝░░░░░╚═╝╚═╝╚═╝░░╚══╝╚═╝░░╚═╝╚══════╝

Which terminals do you want to install?
\e[0m"
install st alacritty yakuake terminator guake tilda tilix terminology wezterm xterm cool-retro-term gnome-console gnome-terminal konsole xfce4-terminal lxterminal

#_____________________________________________________________________________

echo -e "\e[32m
███████╗██████╗░██╗████████╗░█████╗░██████╗░
██╔════╝██╔══██╗██║╚══██╔══╝██╔══██╗██╔══██╗
█████╗░░██║░░██║██║░░░██║░░░██║░░██║██████╔╝
██╔══╝░░██║░░██║██║░░░██║░░░██║░░██║██╔══██╗
███████╗██████╔╝██║░░░██║░░░╚█████╔╝██║░░██║
╚══════╝╚═════╝░╚═╝░░░╚═╝░░░░╚════╝░╚═╝░░╚═╝

Which editors do you want to install? (separate by space, e.g. 'neovim, vscodium-bin')
\e[0m"
install vi vim emacs neovim neovim-nightly-bin nano visual-studio-code-bin vscodium-bin gedit notepadqq kate leafpad code

#_____________________________________________________________________________

echo -e "\e[32m
██╗░░░██╗██╗██████╗░████████╗██╗░░░██╗░█████╗░██╗░░░░░██╗███████╗░█████╗░████████╗██╗░█████╗░███╗░░██╗
██║░░░██║██║██╔══██╗╚══██╔══╝██║░░░██║██╔══██╗██║░░░░░██║╚════██║██╔══██╗╚══██╔══╝██║██╔══██╗████╗░██║
╚██╗░██╔╝██║██████╔╝░░░██║░░░██║░░░██║███████║██║░░░░░██║░░███╔═╝███████║░░░██║░░░██║██║░░██║██╔██╗██║
░╚████╔╝░██║██╔══██╗░░░██║░░░██║░░░██║██╔══██║██║░░░░░██║██╔══╝░░██╔══██║░░░██║░░░██║██║░░██║██║╚████║
░░╚██╔╝░░██║██║░░██║░░░██║░░░╚██████╔╝██║░░██║███████╗██║███████╗██║░░██║░░░██║░░░██║╚█████╔╝██║░╚███║
░░░╚═╝░░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░░╚═════╝░╚═╝░░╚═╝╚══════╝╚═╝╚══════╝╚═╝░░╚═╝░░░╚═╝░░░╚═╝░╚════╝░╚═╝░░╚══╝

Which virtualization platforms do you want to install? (virtualbox, vmware, quickemu, qemu-full)
\e[0m"
install virtualbox quickemu quickgui-bin qemu-full

#_____________________________________________________________________________

echo -e "\e[32m
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

What password manager do you want to install?
\e[0m"
install pass keepassxc bitwarden lastpass 1password seahorse

#_____________________________________________________________________________

echo -e "\e[32m
██████╗░███████╗███╗░░░███╗░█████╗░████████╗███████╗  ██████╗░███████╗░██████╗██╗░░██╗████████╗░█████╗░██████╗░
██╔══██╗██╔════╝████╗░████║██╔══██╗╚══██╔══╝██╔════╝  ██╔══██╗██╔════╝██╔════╝██║░██╔╝╚══██╔══╝██╔══██╗██╔══██╗
██████╔╝█████╗░░██╔████╔██║██║░░██║░░░██║░░░█████╗░░  ██║░░██║█████╗░░╚█████╗░█████═╝░░░░██║░░░██║░░██║██████╔╝
██╔══██╗██╔══╝░░██║╚██╔╝██║██║░░██║░░░██║░░░██╔══╝░░  ██║░░██║██╔══╝░░░╚═══██╗██╔═██╗░░░░██║░░░██║░░██║██╔═══╝░
██║░░██║███████╗██║░╚═╝░██║╚█████╔╝░░░██║░░░███████╗  ██████╔╝███████╗██████╔╝██║░╚██╗░░░██║░░░╚█████╔╝██║░░░░░
╚═╝░░╚═╝╚══════╝╚═╝░░░░░╚═╝░╚════╝░░░░╚═╝░░░╚══════╝  ╚═════╝░╚══════╝╚═════╝░╚═╝░░╚═╝░░░╚═╝░░░░╚════╝░╚═╝░░░░░

Which remote desktop softwares do you want to install?
\e[0m"
install x11vnc rustdesk-bin teamviewer anydesk-bin remmina parsec-bin realvnc-vnc-viewer nomachine

#_____________________________________________________________________________

echo -e "\e[32m
███████╗██╗██╗░░░░░███████╗  ███╗░░░███╗░█████╗░███╗░░██╗░█████╗░░██████╗░███████╗██████╗░
██╔════╝██║██║░░░░░██╔════╝  ████╗░████║██╔══██╗████╗░██║██╔══██╗██╔════╝░██╔════╝██╔══██╗
█████╗░░██║██║░░░░░█████╗░░  ██╔████╔██║███████║██╔██╗██║███████║██║░░██╗░█████╗░░██████╔╝
██╔══╝░░██║██║░░░░░██╔══╝░░  ██║╚██╔╝██║██╔══██║██║╚████║██╔══██║██║░░╚██╗██╔══╝░░██╔══██╗
██║░░░░░██║███████╗███████╗  ██║░╚═╝░██║██║░░██║██║░╚███║██║░░██║╚██████╔╝███████╗██║░░██║
╚═╝░░░░░╚═╝╚══════╝╚══════╝  ╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝░░╚══╝╚═╝░░╚═╝░╚═════╝░╚══════╝╚═╝░░╚═╝

Which file managers do you want to install?
\e[0m"
install nautilus dolphin ranger krusader nemo thunar caja konqueror pcmanfm xplr worker vifm

#_____________________________________________________________________________

echo -e "\e[32m
░█████╗░░█████╗░██╗░░░░░███████╗███╗░░██╗██████╗░░█████╗░██████╗░
██╔══██╗██╔══██╗██║░░░░░██╔════╝████╗░██║██╔══██╗██╔══██╗██╔══██╗
██║░░╚═╝███████║██║░░░░░█████╗░░██╔██╗██║██║░░██║███████║██████╔╝
██║░░██╗██╔══██║██║░░░░░██╔══╝░░██║╚████║██║░░██║██╔══██║██╔══██╗
╚█████╔╝██║░░██║███████╗███████╗██║░╚███║██████╔╝██║░░██║██║░░██║
░╚════╝░╚═╝░░╚═╝╚══════╝╚══════╝╚═╝░░╚══╝╚═════╝░╚═╝░░╚═╝╚═╝░░╚═╝

Which calendars do you want to install?
\e[0m"
install calcurse korganizer deepin-calendar nextcloud-app-calendar gcalcli

#_____________________________________________________________________________

if  [[ $USER == "ramin" ]]; then
    sudo pacman -Syu gnupg mpg123 python-pip pass-otp zbar wget pavucontrol pamixer playerctl unzip xorg nodejs tldr lsd flatpak ncdu btop bash-completion traceroute tree trash-cli cronie vi linux-headers electron cairo gtk3 gobject-introspection desktop-file-utils xdg-utils xdg-user-dirs gtk-update-icon-cache shared-mime-info mesa-utils wine gnutls lib32-gnutls libpulse lib32-libpulse

    pip install neovim langdetect shell-gpt --user
    cd ~/ && git clone https://aur.archlinux.org/python-gtts.git && cd python-gtts/ && makepkg -sif --clean

    $aur -Syu ruby npm yarn pnpm appimagelauncher fd lazygit libguestfs dmidecode virt-manager ebtables iptables virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat powershell-bin w3m xclip openrazer-daemon openrazer-driver-dkms openrazer-meta python-openrazer polychromatic bc ufw fail2ban ngrok jq mpv ueberzug ffmpeg ffmpeg4.4 yt-dlp dust ripgrep fzf ranger ueberzug dust nmap whois calcurse amdguid-glow-bin vulkan-amdgpu-pro lib32-vulkan-amdgpu-pro
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
fi

reboot
