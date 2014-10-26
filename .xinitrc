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
#dropboxd &
#xfce4-notes &
firefox &
blueman-applet &
#hamster &
clipit &
workrave &
${HOME}/.screenlayout/single-monitor.sh &>> ~/.scrsetup.log
#${HOME}/.screenlayout/dual-monitor.sh &>> ~/.scrsetup.log
#${HOME}/.screenlayout/watson.sh &>> ~/.scrsetup.log

#conky | while read -r; do xsetroot -name "$REPLY"; done &
(conky | while read LINE; do xsetroot -name "$LINE"; done) &
#${HOME}/localhost/dwmstatus/dwmstatus &>> ~/.dwmstatus.log &

#feh --bg-scale /home/paullik/Documents/backgrounds/toronto.png &

unclutter -jitter 5 -idle 2 &

#workrave &
wmname LG3D &

exec ${HOME}/localhost/dwm/dwm
#exec startlxde
#exec i3
#exec i3 -V >> ~/.i3/i3log 2>&1
