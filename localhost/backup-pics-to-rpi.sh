#! /bin/sh

# backup- Pictures to RPi via rsync
# rpi is the ssh URI for the raspberry pi

rsync -avh --progress --delete Pictures/ rpi:/var/exports/Pictures/