# Easy Aliases
alias update='sudo pacman -Syu --noconfirm && flatpak update -y && paru -Syu'
alias install='paru -Syu'
alias search='paru -Ss'
alias uninstall='paru -Rns --noconfirm'
alias clean='sudo pacman -Scc'
alias explain='tldr'
alias packages='sudo pacman -Qe'
alias roblox='grapejuice app && exit'
alias bios='systemctl reboot --firmware-setup'
alias pass-save='pass git push origin master'
function get-function() {
  sed -n '/^function '$1'() {/,/^}/p' $2
}

# YouTube Aliases
alias youtube='ytfzf -t'
alias channel='ytfzf -t --type=channel'
alias ctt='ytfzf -t --type=channel https://www.youtube.com/channel/UCg6gPGh8HU2U01vaFCAsvmQ'
alias dt='ytfzf -t --type=channel https://www.youtube.com/channel/UCVls1GmFKf6WlTraIb_IaJg'
alias bugswriter='ytfzf -t --type=channel https://www.youtube.com/channel/UCngn7SVujlvskHRvRKc1cTw'
alias brodie='ytfzf -t --type=channel https://www.youtube.com/channel/UCld68syR8Wi-GY_n4CaoJGA'
alias mental-outlaw='ytfzf -t --type=channel https://www.youtube.com/channel/UC7YOGHUfC1Tb6E4pudI9STA'
function playlist() {
  played=false

  echo "
  Type a number in order to play:
    1. Nasheed Taweel Alshawq - Ahmed Bukhatir - أحمد بوخاطر - نشيد طويل الشوق
    2. Mishary Rashid Alafasy - انيلع ردبلا علط
    3. Mishary Rashid Alafasy - هللا الإ هلإ ال
    4. Mishary Rashid Alafasy - ىوهلا ماش ىلع يكبأ
    5. Mishary Rashid Alafasy - ةخسنلا_دبعلا انا_ ينيد ديشن لمجا
    6. Mishary Rashid Alafasy - ىفطصم
    7. Mishary Rashid Alafasy - نمحر اي نمحر
  "

  read number

  if [[ "$number" == 1 ]]; then
    played=true
    ytfzf -a -m https://www.youtube.com/watch?v=o2W8_mvLuxU # Nasheed Taweel Alshawq - Ahmed Bukhatir - أحمد بوخاطر - نشيد طويل الشوق
  fi
  if [[ "$number" == 2 || "$played" == true ]]; then
    played=true
    ytfzf -a -m https://www.youtube/watch?v=r716ZlTWXSU # Mishary Rashid Alafasy - انيلع ردبلا علط
  fi
  if [[ "$number" == 3 || "$played" == true ]]; then
    played=true
    ytfzf -a -m https://www.youtube.com/watch?v=4yWLofNagy8 # Mishary Rashid Alafasy - هللا الإ هلإ ال
  fi
  if [[ "$number" == 4 || "$played" == true ]]; then
    played=true
    ytfzf -a -m https://www.youtube.com/watch?v=BJYKctYt06w # Mishary Rashid Alafasy - ىوهلا ماش ىلع يكبأ
  fi
  if [[ "$number" == 5 || "$played" == true ]]; then
    played=true
    ytfzf -a -m https://www.youtube.com/watch?v=JDx4mER0Dww # Mishary Rashid Alafasy - ةخسنلا_دبعلا انا_ ينيد ديشن لمجا
  fi
  if [[ "$number" == 6 || "$played" == true ]]; then
    played=true
    ytfzf -a -m https://www.youtube.com/watch?v=vfNI24pIEBY # Mishary Rashid Alafasy - ىفطصم
  fi
  if [[ "$number" == 7 || "$played" == true ]]; then
    played=true
    ytfzf -a -m https://www.youtube.com/watch?v=M3xjz4nxzGQ # Mishary Rashid Alafasy - نمحر اي نمحر
  else
    echo "Please type a number between the scope"
  fi
}

# Easy Remote
function enable-remote() {
xrandr --listactivemonitors\
|awk -- 'BEGIN { getline } { gsub(/\/[[:digit:]]+/,"",$3) ; print $3 }'\
|while read GEOMETRY
do
  x11vnc -forever -ncache 10 -clip $GEOMETRY &
done
}

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

# ChatGPT requires gtts-cli, sgpt and mpg123
function chatgpt() {
  local answer=$(sgpt --no-animation "$*")
  echo "$answer"
  language=$(echo "$*" | python -c "from langdetect import detect; print(detect('$*'))" 2>/dev/null)
  gtts-cli -l "$language" "$answer" --output tts.mp3
  mpg123 -q ~/tts.mp3
}

# Network Aliases
alias ping='ping -c 3'
alias ip='ip -c'
function open-ports(){
    sudo nmap -sS "$1" | grep -e 'report' -e 'PORT' -e 'open'
}

# Google
function google() {
  w3m "https://www.google.com/search?ie=ISO-8859-1&hl=sv&source=hp&q=$*&btnG=S%F6k+p%E5+Google&iflsig=AK50M_UAAAAAZAIv17_xwHM88aV_QoLWT_jXW-7k-JbZ&gbv=1"
}

# Keybinds
bind -x '"\C-k": "calcurse"'
bind -x '"\C-f": "ranger"'
bind -x '"\C-v": "clear; curl -s sv.wttr.in/57.792506,11.997145?M | tail +2"'
bind -x '"\C-l": "clear; paleofetch; echo \n"'
paleofetch
