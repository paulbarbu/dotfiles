#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

#xfce4-power-manager &

kalu &
dropboxd &
xfce4-notes &
firefox &
blueman-applet &
#${HOME}/.screenlayout/dual-monitor-samsung.sh
${HOME}/.screenlayout/single-monitor.sh

#conky | while read -r; do xsetroot -name "$REPLY"; done &

${HOME}/localhost/dwmstatus/dwmstatus &

feh --bg-scale /home/paullik/Documents/backgrounds/toronto.png &

unclutter -jitter 5 -idle 2 &

workrave &

exec ${HOME}/localhost/dwm/dwm
