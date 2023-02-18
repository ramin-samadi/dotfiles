#!/bin/bash
sudo pacman -Syu vim xorg

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

setxkbmap se
exec dwm
' > ~/.xinitrc

echo '
#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
startx
' > ~/.bash_profile && source ~/.bash_profile
