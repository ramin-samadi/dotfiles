# Easy Aliases
alias update='sudo pacman -Syu --noconfirm && flatpak update -y && paru -Syu'
alias install='paru -Syu'
alias cdtest='cd'
alias search='paru -Ss'
alias uninstall='paru -Rns --noconfirm'
alias clean='sudo pacman -Scc'
alias remove='rm'
alias rename='mv'
alias explain='tldr'
alias packages='sudo pacman -Qe'
alias roblox='grapejuice app && exit'
alias bios='systemctl reboot --firmware-setup'

# YouTube Aliases
alias youtube='ytfzf -t'
alias channel='ytfzf -t --type=channel'
alias ctt='ytfzf -t --type=channel https://www.youtube.com/channel/UCg6gPGh8HU2U01vaFCAsvmQ'
alias dt='ytfzf -t --type=channel https://www.youtube.com/channel/UCVls1GmFKf6WlTraIb_IaJg'
alias bugswriter='ytfzf -t --type=channel https://www.youtube.com/channel/UCngn7SVujlvskHRvRKc1cTw'
alias brodie='ytfzf -t --type=channel https://www.youtube.com/channel/UCld68syR8Wi-GY_n4CaoJGA'
alias mental-outlaw='ytfzf -t --type=channel https://www.youtube.com/channel/UC7YOGHUfC1Tb6E4pudI9STA'

# GitHub Aliases
alias clone='git clone'
alias status='git status'
alias add='git add'
function commit() {
	git commit -m "$*"
}
alias pull='git pull'
alias push='git push'
alias log='git log'

# Network Aliases
alias ping='ping -c 3'
alias ip='ip -c'

command_not_found_handle() {
	~/.local/bin/command-finder "$1"
	return $?
}

# Keybinds
bind -x '"\C-k": "calcurse"'
bind -x '"\C-v": "clear; curl -s sv.wttr.in/57.792506,11.997145?M | tail +2"'
bind -x '"\C-l": "clear; paleofetch; echo \n"'
paleofetch
