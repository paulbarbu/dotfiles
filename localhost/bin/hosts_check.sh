#! /bin/bash

# This script checks whether some hosts are accessible on the home/public network
# It is intended to be run by a cron job and to notify the owner via email if the hosts are down

# TODO: use declare -A to use an associative array and friendly names
home_network=192.168.0
home_addrs=(192.168.0.202 192.168.0.251 192.168.0.123)
public_addrs=(paullik.ddns.net)

function check_host
{
    ping -q -c 1 $1 > /dev/null

    # if host is offline
    if [[ 0 -ne $? ]]; then

        # check if I already sent an email
        if [[ ! -f "/tmp/$1" ]]; then
            subject="$1 OFFLINE!"
            echo $subject
            ./localhost/bin/sendmail.sh "$subject" "$1 is offline!"

            touch "/tmp/$1"
        fi
    else        
        echo "$1 ONLINE!"
        if [[ -f "/tmp/$1" ]]; then
            rm "/tmp/$1" 
        fi
    fi
}

eth0=$(ip -f inet address show eth0 | grep inet | cut -d ' ' -f 6 | cut -d '.' -f 1,2,3)
wlan0=$(ip -f inet address show wlan0 | grep inet | cut -d ' ' -f 6 | cut -d '.' -f 1,2,3)

echo $(date)

# if the IP starts with the home prefix, I can assume that I'm connected to my router
if [[ $home_network = $eth0 ]] || [[ $home_network = $wlan0 ]]; then
    for addr in "${home_addrs[@]}"; do
        check_host $addr
    done
fi

# if I have any IP then I assume I am connected to the internet
if [[ -n $eth0 ]] || [[ -n $wlan0 ]]; then
    for addr in "${public_addrs[@]}"; do
        check_host $addr
    done
fi
