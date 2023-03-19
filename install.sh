#!/bin/bash

#_____________________________________________________________________________
git clone https://aur.archlinux.org/smenu.git ~/.config/smenu && cd ~/.config/smenu && makepkg -sif –clean && clear

echo -e "\e[32m
░█████╗░██╗░░░██╗██████╗░  ██╗░░██╗███████╗██╗░░░░░██████╗░███████╗██████╗░
██╔══██╗██║░░░██║██╔══██╗  ██║░░██║██╔════╝██║░░░░░██╔══██╗██╔════╝██╔══██╗
███████║██║░░░██║██████╔╝  ███████║█████╗░░██║░░░░░██████╔╝█████╗░░██████╔╝
██╔══██║██║░░░██║██╔══██╗  ██╔══██║██╔══╝░░██║░░░░░██╔═══╝░██╔══╝░░██╔══██╗
██║░░██║╚██████╔╝██║░░██║  ██║░░██║███████╗███████╗██║░░░░░███████╗██║░░██║
╚═╝░░╚═╝░╚═════╝░╚═╝░░╚═╝  ╚═╝░░╚═╝╚══════╝╚══════╝╚═╝░░░░░╚══════╝╚═╝░░╚═╝

Which aur helpers do you want to install?
\e[0m"
options=(yay paru pakku aurutils trizen pikaur aura)

selected_options=()

while true; do
    remaining_options=("Next" "${options[@]}")

    for selected in "${selected_options[@]}"; do
        remaining_options=("${remaining_options[@]/$selected}")
    done

    selected=$(printf "%s\n" "${remaining_options[@]}" | smenu -c -N "Select which aur helper to install:")

    if [ "$selected" == "Next" ]; then
        clear && break
    fi

    selected_options+=("$selected")
done

for option in "${selected_options[@]}"; do
    git clone https://aur.archlinux.org/$option.git ~/$option && cd ~/$option/ && makepkg -sif –clean && clear
    aur=$option
done

install() {
    options=("$@")
    selected_options=()

    while true; do
        remaining_options=("Next" "${options[@]}")

        for selected in "${selected_options[@]}"; do
            remaining_options=("${remaining_options[@]/$selected}")
        done

        selected=$(printf "%s\n" "${remaining_options[@]}" | smenu -c -N "Select which to install:")

        if [ "$selected" == "Next" ]; then
            clear && break
        fi

        selected_options+=("$selected")
    done

    for option in "${selected_options[@]}"; do
        $aur -Syu "$option" && clear
        
        if [ "$option" == "pass" ]; then
            $aur -Syu gnupg pass-otp zbar xclip git-remote-gcrypt passmenu-otp-git && clear
        elif [ "$option" == "qemu-full" ]; then
            $aur -Syu dmidecode virt-manager ebtables iptables virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat powershell-bin && clear
        fi
    done
}

#_____________________________________________________________________________


#_____________________________________________________________________________

if  [[ $USER == "ramin" ]]; then
    $aur -Syu --needed - < ~/dwm/packages.txt
    
    pip install neovim langdetect shell-gpt --user
    cd ~/ && git clone https://aur.archlinux.org/python-gtts.git && cd python-gtts/ && makepkg -sif --clean

    gem install neovim && sudo npm install -g neovim 
    sudo gpasswd -a $USER plugdev
    sudo systemctl enable --now libvirtd.service && sudo usermod -a -G libvirt $(whoami) && sudo systemctl restart libvirtd.service
    sudo virsh net-start default
    sudo virsh net-autostart default
    sudo systemctl restart libvirtd.service
    git clone https://aur.archlinux.org/paleofetch-git.git ~/paleofetch && cd ~/paleofetch/ && makepkg -sif –clean
    cd && git clone https://github.com/pystardust/ytfzf && cd ytfzf && sudo make install doc && sudo make addons

    git clone --depth=1 https://gitlab.com/brinkervii/grapejuice.git /tmp/grapejuice && cd /tmp/grapejuice && ./install.py
    cd && wget https://github.com/raminsamadi123/hyprinstall/releases/download/Fonts/Meslo-fonts.zip && unzip Meslo-fonts.zip && sudo rm -rf Meslo-fonts.zip
    git clone https://github.com/christitustech/mybash ~/mybash && cd ~/mybash/ && ./setup-arch.sh
    sudo pacman -S --needed lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader
    sudo ufw enable && sudo systemctl enable --now ufw.service

    cd
    git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git
    make -C ble.sh install PREFIX=~/.local
    echo 'source ~/.local/share/blesh/ble.sh' >> ~/.bashrc

    sudo sed -i 's/#Color/Color/g' /etc/pacman.conf && sudo sed -i 's/#NoProgressBar/ILoveCandy/g' /etc/pacman.conf && sudo sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 5/g' /etc/pacman.conf
    sudo sed -i 's/ls -Fls/lsd -Fla/g' ~/.bashrc && sudo sed -i 's/ls -aFh/lsd -aFh/g' ~/.bashrc && sed -i 's,/usr/bin/grep $GREP_OPTIONS,grep --color,g' ~/.bashrc
    
    sudo bash -c "echo '58,18 * * * * pacman -Syu --noconfirm && flatpak update -y && paru -Syu && yes J | pacman -Scc' >> /var/spool/cron/root" && sudo systemctl stop cronie && sudo systemctl enable cronie.service && sudo systemctl start cronie.service
    bash -c "echo '58,18 * * * * /home/ramin/.local/bin/update-dwm' >> /var/spool/cron/$USER" && systemctl stop cronie && systemctl enable cronie.service && systemctl start cronie.service

    git clone https://aur.archlinux.org/st.git ~/.config/st && cd ~/.config/st/ && makepkg -sif –clean && cp config.def.h config.h
    git clone https://aur.archlinux.org/dwm.git ~/.config/dwm && cd ~/.config/dwm/ && makepkg -sif –clean

    git clone https://github.com/LazyVim/starter ~/.config/nvim
    rm -rf ~/.config/nvim/.git
    
    mv ~/dwm/.xinitrc ~/
    mv ~/dwm/ranger/rc.conf ~/.config/ranger/
    mv -f ~/dwm/.bash_profile ~/
    cat ~/dwm/.bashrc >> ~/.bashrc
    mv -f ~/dwm/dwm/config.h ~/.config/dwm/ && cd ~/.config/dwm/ && makepkg -sif --clean
    mv -f ~/dwm/st/config.h ~/.config/st/ && cd ~/.config/st/ && makepkg -sif --clean
    sudo rm -rf ~/dwm/
    mv ~/paru/ ~/.config/
    mv ~/paleofetch/ ~/.config/
    sudo rm -rf ~/.bashrc.bak
    cd

    source ~/.bashrc
    source ~/.bash_profile
fi

reboot
