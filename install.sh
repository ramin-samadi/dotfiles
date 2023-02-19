#!/bin/bash
sudo pacman -Syu wget git pamixer firefox unzip vim xorg nodejs tldr lsd flatpak nvidia-settings ncdu btop bash-completion traceroute tree trash-cli cronie vi linux-headers electron
flatpak install net.brinkervii.grapejuice -y

git clone https://aur.archlinux.org/paru.git ~/paru && cd ~/paru/ && makepkg -sif –clean
git clone https://aur.archlinux.org/yay.git ~/yay && cd ~/yay/ && makepkg -sif –clean
paru -Syu powerpill appimagelauncher spotify
git clone https://aur.archlinux.org/paleofetch-git.git ~/paleofetch && cd ~/paleofetch/ && makepkg -sif –clean
sudo pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key FBA220DFC880C036
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
sudo sh -c "echo -e '\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist' >> /etc/pacman.conf"
sudo pacman -Sy && sudo powerpill -Su && paru -Su

cd && wget https://github.com/raminsamadi123/hyprinstall/releases/download/Fonts/Meslo-fonts.zip
unzip Meslo-fonts.zip
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

echo "
#Easy Aliases
alias update='sudo pacman -Syu --noconfirm && flatpak update -y && paru -Syu'
alias install='sudo pacman -Syu'
alias search='sudo pacman -Ss'
alias uninstall='sudo pacman -Rns --noconfirm'
alias cls='clear'
alias clean='sudo pacman -Scc'
alias explain='tldr'
alias packages='sudo pacman -Qe'
alias aur='sudo pacman -U'
alias clone='git clone'
alias bat='cat'
alias bios='systemctl reboot --firmware-setup'
bind -x '\"\\C-l\": \"clear; paleofetch\"'
paleofetch
" >> ~/.bashrc && source ~/.bashrc

sudo bash -c "echo '58,18 * * * * sudo pacman -Syu --noconfirm && flatpak update -y && paru -Syu' >> /var/spool/cron/root"
sudo systemctl stop cronie && sudo systemctl enable cronie.service && sudo systemctl start cronie.service

git clone https://aur.archlinux.org/st.git ~/bin && cd ~/bin/ && makepkg -sif –clean && cp config.def.h config.h
git clone https://aur.archlinux.org/dwm.git ~/bin/dwm && cd ~/bin/dwm/ && makepkg -sif –clean

cd ~/bin/
sudo sed -i 's/pixelsize=12/pixelsize=14/g' ~/bin/config.h
makepkg -if --clean
cd

echo '
// ▄▀█ █▀█ █▀█ █▀▀ ▄▀█ █▀█ ▄▀█ █▄░█ █▀▀ █▀▀
// █▀█ █▀▀ █▀▀ ██▄ █▀█ █▀▄ █▀█ █░▀█ █▄▄ ██▄
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 0;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "monospace:size=10" };
static const char dmenufont[]       = "monospace:size=10";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#005577";
static const char *colors[][3]      = {
        /*               fg         bg         border   */
        [SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
        [SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
};

// ▀█▀ ▄▀█ █▀▀ █▀▀ █ █▄░█ █▀▀
// ░█░ █▀█ █▄█ █▄█ █ █░▀█ █▄█
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
        /* xprop(1):
         *      WM_CLASS(STRING) = instance, class
         *      WM_NAME(STRING) = title
         */
        /* class      instance    title       tags mask     isfloating   monitor */
        { "Gimp",     NULL,       NULL,       0,            1,           -1 },
        { "Firefox",  NULL,       NULL,       1 << 8,       0,           -1 },
};

// █░░ ▄▀█ █▄█ █▀█ █░█ ▀█▀
// █▄▄ █▀█ ░█░ █▄█ █▄█ ░█░
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
        /* symbol     arrange function */
        { "[]=",      tile },    /* first entry is default */
        { "><>",      NULL },    /* no layout function means floating behavior */
        { "[M]",      monocle },
};

// █▄▀ █▀▀ █▄█   █▀▄ █▀▀ █▀▀ █ █▄░█ █ ▀█▀ █ █▀█ █▄░█
// █░█ ██▄ ░█░   █▄▀ ██▄ █▀░ █ █░▀█ █ ░█░ █ █▄█ █░▀█
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
        { MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
        { MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
        { MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
        { MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

// █▀▀ █▀█ █▀▄▀█ █▀▄▀█ ▄▀█ █▄░█ █▀▄
// █▄▄ █▄█ █░▀░█ █░▀░█ █▀█ █░▀█ █▄▀
static const char *dmenucmd[] = { "dmenu_run", "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *termcmd[]  = { "st", NULL };


#include <X11/XF86keysym.h> // Used for getting audio keybind

static const Key keys[] = {
        /* modifier                     key        function        argument */
        { MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
        { MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
        { MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
        { MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
        { MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
        { MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
        { MODKEY,                       XK_Return, zoom,           {0} },
        { MODKEY,                       XK_Tab,    view,           {0} },
        { MODKEY, 	            	      XK_q,      killclient,     {0} },
        { MODKEY|ShiftMask,             XK_t,      setlayout,      {.v = &layouts[0]} },
        { MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
        { MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
        { MODKEY,                       XK_space,  setlayout,      {0} },
        { MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
        { MODKEY,                       XK_0,      view,           {.ui = ~0 } },
        { MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
        { MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
        { MODKEY,                       XK_period, focusmon,       {.i = +1 } },
        { MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
        { MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
        { MODKEY|ShiftMask,             XK_q,      quit,           {0} },

        // BROWSER
        { MODKEY, 			                XK_w, 	   spawn,          SHCMD("firefox") },

        // TERMINAL
        { MODKEY,            		        XK_t, 	   spawn,          {.v = termcmd } },

        // LAUNCHER
        { MODKEY,                       XK_s,      spawn,          {.v = dmenucmd } },

        // PANEL
        { MODKEY,                       XK_b,      togglebar,      {0} },
        TAGKEYS(                        XK_1,                      0)
        TAGKEYS(                        XK_2,                      1)
        TAGKEYS(                        XK_3,                      2)
        TAGKEYS(                        XK_4,                      3)
        TAGKEYS(                        XK_5,                      4)
        TAGKEYS(                        XK_6,                      5)
        TAGKEYS(                        XK_7,                      6)
        TAGKEYS(                        XK_8,                      7)
        TAGKEYS(                        XK_9,                      8)

        // AUDIO
        {0, XF86XK_AudioLowerVolume,              spawn,           SHCMD("pactl set-sink-volume @DEFAULT_SINK@ -5%")},
    	{0, XF86XK_AudioRaiseVolume,              spawn,           SHCMD("pactl set-sink-volume @DEFAULT_SINK@ +5%")},
    	{0, XF86XK_AudioMute,                     spawn,           SHCMD("pactl set-sink-mute @DEFAULT_SINK@ toggle")},
};

// █▄▄ █░█ ▀█▀ ▀█▀ █▀█ █▄░█   █▀▄ █▀▀ █▀▀ █ █▄░█ █ ▀█▀ █ █▀█ █▄░█
// █▄█ █▄█ ░█░ ░█░ █▄█ █░▀█   █▄▀ ██▄ █▀░ █ █░▀█ █ ░█░ █ █▄█ █░▀█
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
        /* click                event mask      button          function        argument */
        { ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
        { ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
        { ClkWinTitle,          0,              Button2,        zoom,           {0} },
        { ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
        { ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
        { ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
        { ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
        { ClkTagBar,            0,              Button1,        view,           {0} },
        { ClkTagBar,            0,              Button3,        toggleview,     {0} },
        { ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
        { ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
' > ~/bin/dwm/config.h && cd ~/bin/dwm/ && makepkg -if --clean

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

setxkbmap se &

# Login Loop
while true; do
        dwm >/dev/null 2>&1
done

# Start DWM
exec dwm
' > ~/.xinitrc

echo '
#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
startx
' > ~/.bash_profile && source ~/.bash_profile
