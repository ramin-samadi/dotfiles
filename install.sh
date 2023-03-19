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

# For more info on 'whiptail' see:
#https://en.wikibooks.org/wiki/Bash_Shell_Scripting/Whiptail

# These exports are the only way to specify colors with whiptail.
# See this thread for more info:
# https://askubuntu.com/questions/776831/whiptail-change-background-color-dynamically-from-magenta/781062
export NEWT_COLORS="
root=,blue
window=,black
shadow=,blue
border=blue,black
title=blue,black
textbox=blue,black
radiolist=black,black
label=black,blue
checkbox=black,blue
compactbutton=black,blue
button=black,red"

## The following functions are defined here for convenience.
## All these functions are used in each of the five window functions.
max() {
	echo -e "$1\n$2" | sort -n | tail -1
}

getbiggestword() {
	echo "$@" | sed "s/ /\n/g" | wc -L
}

replicate() {
	local n="$1"
	local x="$2"
	local str

	for _ in $(seq 1 "$n"); do
		str="$str$x"
	done
	echo "$str"
}

programchoices() {
	choices=()
	local maxlen
	maxlen="$(getbiggestword "${!checkboxes[@]}")"
	linesize="$(max "$maxlen" 42)"
	local spacer
	spacer="$(replicate "$((linesize - maxlen))" " ")"

	for key in "${!checkboxes[@]}"; do
		# A portable way to check if a command exists in $PATH and is executable.
		# If it doesn't exist, we set the tick box to OFF.
		# If it exists, then we set the tick box to ON.
		if ! command -v "${checkboxes[$key]}" >/dev/null; then
			# $spacer length is defined in the individual window functions based
			# on the needed length to make the checkbox wide enough to fit window.
			choices+=("${key}" "${spacer}" "OFF")
		else
			choices+=("${key}" "${spacer}" "ON")
		fi
	done
}

selectedprograms() {
	result=$(
		# Creates the whiptail checklist. Also, we use a nifty
		# trick to swap stdout and stderr.
		whiptail --title "$title" \
			--checklist "$text" 22 "$((linesize + 16))" 12 \
			"${choices[@]}" \
			3>&2 2>&1 1>&3
	)
}

exitorinstall() {
	local exitstatus="$?"
	# Check the exit status, if 0 we will install the selected
	# packages. A command which exits with zero (0) has succeeded.
	# A non-zero (1-255) exit status indicates failure.
	if [ "$exitstatus" = 0 ]; then
		# Take the results and remove the "'s and add new lines.
		# Otherwise, pacman is not going to like how we feed it.
		programs=$(echo "$result" | sed 's/" /\n/g' | sed 's/"//g')
		echo "$programs"
		paru --needed --ask 4 -Syu "$programs" || echo "Failed to install required packages."
	else
		echo "User selected Cancel."
	fi
}

install() {
	local title="${1}"
	local text="${2}"
	declare -A checkboxes

	# Loop through all the remaining arguments passed to the install function
	for ((i = 3; i <= $#; i += 2)); do
		key="${!i}"
		value=""
		eval "value=\${$((i + 1))}"
		if [ -z "$value" ]; then
			value="$key"
		fi
		checkboxes["$key"]="$value"
	done

	programchoices && selectedprograms && exitorinstall
}

# Call the function with any number of applications as arguments. example:
# install "Title" "Description" "Program-1-KEY" "Program-1-VALUE" "Program-2-KEY" "Program-2-VALUE" ...
# Note an empty string "" means that the KEY and the VALUE are the same like "firefox" "firefox" instead you can write "firefox" ""

# Terminal
install "Terminal" "Select one or more terminal emulators to install.\nAll programs marked with '*' are already installed.\nUnselecting them will NOT uninstall them." "st" "" "alacritty" "" "yakuake" "" "terminator" "" "guake" "" "tilda" "" "tilix" "" "terminology" "" "wezterm" "" "xterm" "" "cool-retro-term" "" "gnome-console" "" "gnome-terminal" "" "konsole" "" "xfce4-terminal" "" "lxterminal" ""

# Editor
install "Editor" "Select one or more editors to install.\nAll programs marked with '*' are already installed.\nUnselecting them will NOT uninstall them." "neovim-nightly-bin" "nvim" "vi" "" "vim" "" "emacs" "" "neovim" "nvim" "nano" "" "visual-studio-code-bin" "code" "vscodium-bin" "vscodium" "gedit" "" "notepadqq" "" "kate" "" "leafpad" ""

# Virtualization Platform
install "Virtualization Platform" "Select one or more virtualization platforms to install.\nAll programs marked with '*' are already installed.\nUnselecting them will NOT uninstall them." "qemu-full" "qemu-aarch64" "virtualbox" "" "quickemu" "" "quickgui-bin" "quickgui"

# Password Manager
install "Password Manager" "Select one or more password managers to install.\nAll programs marked with '*' are already installed.\nUnselecting them will NOT uninstall them." "pass" "" "keepassxc" "" "bitwarden" "" "lastpass" "" "1password" "" "seahorse" ""

# Remote Desktop
install "Remote Desktop" "Select one or more remote desktop programs to install.\nAll programs marked with '*' are already installed.\nUnselecting them will NOT uninstall them." "x11vnc" "" "rustdesk-bin" "rustdesk" "teamviewer" "" "anydesk-bin" "anydesk" "remmina" "" "parsec-bin" "parsec" "realvnc-vnc-viewer" "" "nomachine" ""

# File Manager
install "File Manager" "Select one or more file managers to install.\nAll programs marked with '*' are already installed.\nUnselecting them will NOT uninstall them." "ranger" "" "nautilus" "" "dolphin" "" "krusader" "" "nemo" "" "thunar" "caja" "" "konqueror" "" "pcmanfm" "" "xplr" "" "worker" "" "vifm" ""

# Calendar
install "Calendar" "Select one or more calendar programs to install.\nAll programs marked with '*' are already installed.\nUnselecting them will NOT uninstall them." "calcurse" "" "korganizer" "" "deepin-calendar" "" "nextcloud-app-calendar" "" "gcalcli" ""

# Browsers
install "Web Browsers" "Select one or more web browsers to install.\nAll programs marked with '*' are already installed.\nUnselecting them will NOT uninstall them." "brave-bin" "brave" "chromium" "" "firefox" "" "google-chrome" "google-chrome-stable" "icecat-bin" "icecat" "librewolf-bin" "librewolf" "microsoft-edge-stable-bin" "microsoft-edge-stable" "opera" "" "qutebrowser" "" "ungoogled-chromium-bin" "ungoogled-chromium" "vivaldi" "" "waterfox-classic-bin" "waterfox-classic"

# Other internet
install "Other Internet Programs" "Other Internet programs available for installation.\nAll programs marked with '*' are already installed.\nUnselecting them will NOT uninstall them." "deluge" "" "discord" "" "element-desktop" "" "filezilla" "" "geary" "" "hexchat" "" "jitsi-meet-bin" "jitsi-meet-desktop" "mailspring" "" "telegram-desktop" "telegram" "thunderbird" "" "transmission-gtk" ""

# Multimedia
install "Multimedia Programs" "Multimedia programs available for installation.\nAll programs marked with '*' are already installed.\nUnselecting them will NOT uninstall them." "blender" "" "deadbeef" "" "gimp" "" "inkscape" "" "kdenlive" "" "krita" "" "mpv" "" "obs-studio" "obs" "rhythmbox" "" "ristretto" "" "vlc" ""

# Office
install "Office Programs" "Office and productivity programs available for installation.\nAll programs marked with '*' are already installed.\nUnselecting them will NOT uninstall them." "abiword" "" "evince" "" "gnucash" "" "gnumeric" "" "libreoffice-fresh" "lowriter" "libreoffice-still" "lowriter" "scribus" "" "zathura" ""

# Games
install "Games" "Gaming programs available for installation.\nAll programs marked with '*' are already installed.\nUnselecting them will NOT uninstall them." "0ad" "" "gnuchess" "" "lutris" "" "neverball" "" "openarena" "" "steam" "" "supertuxkart" "" "sauerbraten" "sauerbraten-client" "teeworlds" "" "veloren-bin" "veloren" "wesnoth" "" "xonotic" "xonotic-glx"

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
