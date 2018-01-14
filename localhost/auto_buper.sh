#!/bin/sh

##
## DEPENDENCIES: zenity (alternatives, dialog or xmessage)
##
## root's crontab line (# crontab -e):
## 0 19 * * 1 export DISPLAY=:0 && /home/paul/localhost/auto_buper.sh >> /var/log/auto_buper.log 2>&1
##
## Normal user's .bash_profile file:
## [[ $DISPLAY ]] && xhost +local:
## OR add this in .config/fish/config.fish:
## if test $DISPLAY
##     xhost +local: > /dev/null
## end


#export DISPLAY=:0
export BORG_PASSPHRASE=`zenity --password --title="Weekly backup passphrase"`

today=`date +%Y-%m-%d`

echo 'Auto buper script called on' $today

if [ "$?" -eq 1 ]
then
    echo 'User cancelled'
else
    echo 'Automatically starting buper.sh'    
    ./buper.sh remote weekly
fi

unset BORG_PASSPHRASE
unset DISPLAY