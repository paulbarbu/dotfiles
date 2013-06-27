/* See LICENSE file for copyright and license details. */

/* appearance */
static const char font[]            = "dejavu sans mono medium:pixelsize=11";
static const char normbordercolor[] = "#444444";
static const char normbgcolor[]     = "#222222";
static const char normfgcolor[]     = "#bbbbbb";
static const char selbordercolor[]  = "#005577";
static const char selbgcolor[]      = "#005577";
static const char selfgcolor[]      = "#eeeeee";
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const Bool showsystray       = True;     /* False means no systray */
static const Bool showbar           = True;     /* False means no bar */
static const Bool topbar            = True;     /* False means bottom bar */

/* tagging */
static const char *tags[] = { "www", "dev", "chat", "office", "media", "misc", };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Chromium",       NULL,       NULL,       1,            False,       -1 },
	{ "Firefox",        NULL,       NULL,       1,            False,       -1 },
	{ "Qt Creator",     NULL,       NULL,       1<<1,         False,       -1 },
	{ "Pidgin",         NULL,       NULL,       1<<2,         False,       -1 },
	{ "Polly",          NULL,       NULL,       1<<2,            False,       -1 },
	{ "Xfce4-notes",    NULL,       NULL,       1<<5,         False,       -1 },
	{ "Transmission-gtk",    NULL,       NULL,       1<<5,         False,       -1 },
	{ "Thunderbird",    NULL,       NULL,       1<<3,         False,       -1 },
	{ "Vlc",            NULL,       NULL,       1<<4,         False,       -1 },
};

/* layout(s) */
static const float mfact      = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster      = 1;    /* number of clients in master area */
static const Bool resizehints = False; /* True means respect size hints in tiled resizals */

#include "bstack.c"
#include "bstackhoriz.c"
static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "TTT",      bstack },
	{ "===",      bstackhoriz },
    { NULL,       NULL },
};

void
nextlayout(const Arg *arg) {
    Layout *l;
    for (l=(Layout *)layouts;l != selmon->lt[selmon->sellt];l++);
    if (l->symbol && (l + 1)->symbol)
        setlayout(&((Arg) { .v = (l + 1) }));
    else
        setlayout(&((Arg) { .v = layouts }));
}

void
prevlayout(const Arg *arg) {
    Layout *l;
    for (l=(Layout *)layouts;l != selmon->lt[selmon->sellt];l++);
    if (l != layouts && (l - 1)->symbol)
        setlayout(&((Arg) { .v = (l - 1) }));
    else
        setlayout(&((Arg) { .v = &layouts[LENGTH(layouts) - 2] }));
}

/**
 * Function to shift the current view to the left/right
 *
 * http://lists.suckless.org/dev/1104/7590.html
 *
 * @param: "arg->i" stores the number of tags to shift right (positive value)
 *          or left (negative value)
 */
void
shiftview(const Arg *arg) {
	Arg shifted;

	if(arg->i > 0) // left circular shift
		shifted.ui = (selmon->tagset[selmon->seltags] << arg->i)
		   | (selmon->tagset[selmon->seltags] >> (LENGTH(tags) - arg->i));

	else // right circular shift
		shifted.ui = selmon->tagset[selmon->seltags] >> (- arg->i)
		   | selmon->tagset[selmon->seltags] << (LENGTH(tags) + arg->i);

	view(&shifted);
}

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static const char *dmenucmd[] = { "dmenu_run", "-fn", font, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor, NULL };
static const char *termcmd[]  = { "urxvtc", NULL };
static const char *filemancmd[]  = { "thunar", NULL };
static const char *printcmd[]  = { "scrot", NULL };
static const char *suspendcmd[]  = { "systemctl", "suspend", NULL };
static const char *rebootcmd[]  = { "systemctl", "reboot", NULL };
static const char *poweroffcmd[]  = { "systemctl", "poweroff", NULL };
static const char *volupcmd[]  = { "amixer", "sset", "PCM", "10+", NULL };
static const char *voldncmd[]  = { "amixer", "sset", "PCM", "10-", NULL };
static const char *voltogglecmd[]  = { "amixer", "sset", "Master", "toggle", NULL };

#include "selfrestart.c"

#include "mpdcontrol.c"

static Key keys[] = {
	/* modifier                     key        function        argument */
    { 0,                            XK_Print,  spawn,          {.v = printcmd } },
	{ MODKEY,                       XK_r,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_e,      spawn,          {.v = filemancmd } },
	{ MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY,                       XK_Left,   prevlayout,     {0} },
	{ MODKEY,                       XK_Right,  nextlayout,     {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY,                       XK_Up,     shiftview,      {.i = +1} },
	{ MODKEY,                       XK_Down,   shiftview,      {.i = -1} },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
    { MODKEY|ShiftMask,             XK_r,      self_restart,   {0} },
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
	{ MODKEY|ShiftMask|ControlMask, XK_F10,    spawn,          {.v = suspendcmd } },
	{ MODKEY|ShiftMask|ControlMask, XK_F11,    spawn,          {.v = rebootcmd } },
    { MODKEY|ShiftMask|ControlMask, XK_F12,    spawn,          {.v = poweroffcmd } },
    { MODKEY,                       XK_F1,     mpdchange,      {.i = -1} },
    { MODKEY,                       XK_F2,     mpdchange,      {.i = +1} },
    { MODKEY,                       XK_Escape, mpdcontrol,     {0} },
    { MODKEY,                       XK_KP_Enter, spawn,        {.v = voltogglecmd} },
    { MODKEY,                       XK_KP_Add,   spawn,        {.v = volupcmd} },
    { MODKEY,                       XK_KP_Subtract, spawn,        {.v = voldncmd} },
};

/* button definitions */
/* click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkLtSymbol,          0,              Button4,        nextlayout,     {0} },
	{ ClkLtSymbol,          0,              Button5,        prevlayout,     {0} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
	{ ClkTagBar,            0,              Button4,        shiftview,      {.i = +1} },
	{ ClkTagBar,            0,              Button5,        shiftview,      {.i = -1} },
};
