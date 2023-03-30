#include <X11/XF86keysym.h> // Used for getting audio keybind (pamixer must be installed)

// ▄▀█ █▀█ █▀█ █▀▀ ▄▀█ █▀█ ▄▀█ █▄░█ █▀▀ █▀▀
// █▀█ █▀▀ █▀▀ ██▄ █▀█ █▀▄ █▀█ █░▀█ █▄▄ ██▄
static const unsigned int borderpx  = 12;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "Meslo LGS Nerd Font Mono:size=20:bold" };
static const char dmenufont[]       = "Meslo LGS Nerd Font Mono:size=20:bold";
static const char col_gray1[]       = "#1E1E2E";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#000000";
static const char *colors[][3]      = {
  /*               fg         bg         border   */
  [SchemeNorm] = { col_gray2, col_gray1, col_cyan },
  [SchemeSel] =  { col_gray3, col_gray1, col_cyan },
};

// ▀█▀ ▄▀█ █▀▀ █▀▀ █ █▄░█ █▀▀
// ░█░ █▀█ █▄█ █▄█ █ █░▀█ █▄█
static const char *tags[] = { "⌂", "✍", "🎶", "♔", "✆", "⌨", "+" };

static const Rule rules[] = {
  /* xprop(1):
   *          *      WM_CLASS(STRING) = instance, class
   *                   *      WM_NAME(STRING) = title
   *                            */
  /* class      instance    title       tags mask     isfloating   monitor */
  { "Gimp",     NULL,       NULL,       0,            1,           -1 },
  { "Firefox",  NULL,       NULL,       1 << 8,       0,           -1 },
};


// █░░ ▄▀█ █▄█ █▀█ █░█ ▀█▀
// █▄▄ █▀█ ░█░ █▄█ █▄█ ░█░
static const float mfact          = 0.5; /* factor of master area size [0.05..0.95] */
static const int nmaster          = 1;    /* number of clients in master area */
static const int resizehints      = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen   = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
  /* symbol     arrange function */
  { "",      tile },    /* first entry is default */
  { "",      NULL },    /* no layout function means floating behavior */
  { "",      monocle },
};

// █▄▀ █▀▀ █▄█   █▀▄ █▀▀ █▀▀ █ █▄░█ █ ▀█▀ █ █▀█ █▄░█
// █░█ ██▄ ░█░   █▄▀ ██▄ █▀░ █ █░▀█ █ ░█░ █ █▄█ █░▀█
#define SUPER Mod4Mask
#define ALT Mod1Mask
#define TAGKEYS(KEY,TAG) \
  { SUPER,                       KEY,      view,           {.ui = 1 << TAG} }, \
  { SUPER|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
  { SUPER|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
  { SUPER|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

// █▄▀ █▀▀ █▄█ █▄▄ █ █▄░█ █▀▄
// █░█ ██▄ ░█░ █▄█ █ █░▀█ █▄▀
static const Key keys[] = {
    /* modifier                     key        function        argument */

  // █░█░█ █ █▄░█ █▀▄ █▀█ █░█░█   █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀
  // ▀▄▀▄▀ █ █░▀█ █▄▀ █▄█ ▀▄▀▄▀   █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █░▀░█ ██▄ █░▀█ ░█░

    { ALT,                          XK_1,      focusmon,       {.i = -1 } }, //Switch to left monitor
    { ALT,                          XK_2,      focusmon,       {.i = +1 } }, //Switch to right monitor

    { ALT,                          XK_Tab,    focusstack,     {.i = +1 } }, //Scroll focus between windows

    { SUPER|ShiftMask,              XK_l,      tagmon,         {.i = -1 } }, //Move window to the right
    { SUPER|ShiftMask,              XK_j,      tagmon,         {.i = +1 } }, //Move window to the left

    { SUPER,                        XK_i,      incnmaster,     {.i = +1 } }, //Switch master layout
    { SUPER,                        XK_o,      incnmaster,     {.i = -1 } }, //Switch master layout

    { SUPER,                        XK_Left,   setmfact,       {.f = -0.05} }, //Resize window to the left
    { SUPER,                        XK_Right,  setmfact,       {.f = +0.05} }, //Resize window to the right

    { SUPER,                        XK_j,      zoom,           {1} }, //Switch position of window
    { SUPER,                        XK_l,      zoom,           {0} }, //Switch position of window

    { SUPER,                        XK_f,      setlayout,      {.v = &layouts[2]} }, //Fullscreen
    { SUPER|ShiftMask,              XK_f,      togglefloating, {0} }, //Float
    { SUPER|ShiftMask,              XK_t,      setlayout,      {.v = &layouts[0]} }, //Tiling

    // █▀█ █░█ █ ▀█▀
    // ▀▀█ █▄█ █ ░█░

    { SUPER,                        XK_q,      killclient,     {0} }, //Quit App
    { SUPER|ShiftMask,              XK_q,      quit,           {0} }, //Quit DWM

    // ▄▀█ █▀█ █▀█
    // █▀█ █▀▀ █▀▀

    { SUPER,                        XK_w,      spawn,          SHCMD("google-chrome-stable") }, //Browser
    { SUPER,                        XK_y,      spawn,          SHCMD("youtube") }, //YouTube
    { SUPER,                        XK_t,      spawn,          SHCMD("alacritty") }, //Terminal
    { SUPER,                        XK_s,      spawn,          SHCMD("dmenu_run") }, //Search
    { SUPER,                        XK_p,      spawn,          SHCMD("passmenu-otp") }, //Password Manager
    { SUPER,                        XK_m,      spawn,          SHCMD("playlist") }, //Playlist
    { SUPER,                        XK_x,      spawn,          SHCMD("power-menu") }, //Power Menu
    { SUPER,                        XK_a,      spawn,          SHCMD("anime") }, //Anime
    { SUPER,                        XK_k,      spawn,          SHCMD("calendar") }, //Calendar
    { SUPER,                        XK_c,      spawn,          SHCMD("color-picker") }, //Color Picker
    { SUPER,                        XK_d,      spawn,          SHCMD("date-time-notification") }, //Date & Time (dunst)
    { SUPER|ShiftMask,              XK_s,      spawn,          SHCMD("flameshot gui") }, //Screenshot

    // █▀█ ▄▀█ █▄░█ █▀▀ █░░
    // █▀▀ █▀█ █░▀█ ██▄ █▄▄

    { SUPER,                        XK_b,      togglebar,      {0} },
    TAGKEYS(                        XK_1,                      0)
    TAGKEYS(                        XK_2,                      1)
    TAGKEYS(                        XK_3,                      2)
    TAGKEYS(                        XK_4,                      3)
    TAGKEYS(                        XK_5,                      4)
    TAGKEYS(                        XK_6,                      5)
    TAGKEYS(                        XK_7,                      6)
    TAGKEYS(                        XK_8,                      7)
    TAGKEYS(                        XK_9,                      8)

    // █▀▄▀█ █░█ █░░ ▀█▀ █ █▀▄▀█ █▀▀ █▀▄ █ ▄▀█
    // █░▀░█ █▄█ █▄▄ ░█░ █ █░▀░█ ██▄ █▄▀ █ █▀█

    {0, XF86XK_AudioLowerVolume,              spawn,           SHCMD("pactl set-sink-volume @DEFAULT_SINK@ -5%")},
    {0, XF86XK_AudioRaiseVolume,              spawn,           SHCMD("pactl set-sink-volume @DEFAULT_SINK@ +5%")},
    {0, XF86XK_AudioMute,                     spawn,           SHCMD("pactl set-sink-mute @DEFAULT_SINK@ toggle")},

    {0, XF86XK_AudioPlay,                     spawn,           SHCMD("playerctl play-pause")},
    {0, XF86XK_AudioNext,                     spawn,           SHCMD("playerctl next")},
    {0, XF86XK_AudioPrev,                     spawn,           SHCMD("playerctl previous")},
 };

// █▄▄ █░█ ▀█▀ ▀█▀ █▀█ █▄░█   █▀▄ █▀▀ █▀▀ █ █▄░█ █ ▀█▀ █ █▀█ █▄░█
// █▄█ █▄█ ░█░ ░█░ █▄█ █░▀█   █▄▀ ██▄ █▀░ █ █░▀█ █ ░█░ █ █▄█ █░▀█
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
  /* click                event mask      button          function        argument */
  { ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
  { ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
  { ClkStatusText,        0,              Button2,        spawn,          SHCMD("st") },
  { ClkWinTitle,          0,              Button2,        zoom,           {0} },
  { ClkClientWin,         SUPER,         Button1,        movemouse,      {0} },
  { ClkClientWin,         SUPER,         Button2,        togglefloating, {0} },
  { ClkClientWin,         SUPER,         Button3,        resizemouse,    {0} },
  { ClkTagBar,            0,              Button1,        view,           {0} },
  { ClkTagBar,            0,              Button3,        toggleview,     {0} },
  { ClkTagBar,            SUPER,         Button1,        tag,            {0} },
  { ClkTagBar,            SUPER,         Button3,        toggletag,      {0} },
};
