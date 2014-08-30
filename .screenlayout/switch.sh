#!/bin/sh

WATSON="DVI-0"
BENQ="VGA-0"
CURRENT=`xrandr | egrep "[[:digit:]]{1,3}mm x [[:digit:]]{1,3}mm" | cut -d " " -f 1`

if [[ "$WATSON" == "$CURRENT" ]]
then
    ~/.screenlayout/single-monitor.sh
else
    ~/.screenlayout/watson.sh
fi



