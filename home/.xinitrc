#!/bin/sh
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
WALLPAPER=$(cat $HOME/xwallpaper)

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

if [ -d /etc/X11/xinit/xinitrc.d ]; then
	for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

# Keyboard layout
setxkbmap se &
eww daemon &
eww open bar &
eww open bar2 &

xwallpaper --zoom "$WALLPAPER" &

# Background
xflux -l 57.792506 -g 11.997145 &

# Monitor
xrandr --output DisplayPort-0 --mode 1920x1080 --rate 165.00 &

# Compositor
picom -f &

# Keyboard layout
setxkbmap se &

# Login Loop
while true; do
	dwm >/dev/null 2>&1
done

# Multimedia
/usr/bin/pipewire &
/usr/bin/pipewire-pulse &
/usr/bin/pipewire-media-session &

# Start KDE Polkit (used for password prompts for some applications)
/usr/lib/polkit-kde-authentication-agent-1 &
/usr/bin/dunst &

# Start DWM
exec dbus-run-session dwm
