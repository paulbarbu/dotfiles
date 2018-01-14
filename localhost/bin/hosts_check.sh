#! /bin/bash

# This script checks whether some hosts are accessible on the home/public network
# It is intended to be run by a cron job and to notify the owner via email if the hosts are down

function check_host
{
    ping -q -c 1 $1 > /dev/null

    if [[ 0 -ne $? ]]; then
        subject="$1 OFFLINE!"
        echo $subject
        ./localhost/bin/sendmail.sh "$subject" "$1 is offline!"
    fi
}

home_network=192.168.0
home_addrs=(192.168.0.202 192.168.0.251)
public_addrs=(paulhost.dlinkddns.com)

eth0=$(ip -f inet address show eth0 | grep inet | cut -d ' ' -f 6 | cut -d '.' -f 1,2,3)
wlan0=$(ip -f inet address show wlan0 | grep inet | cut -d ' ' -f 6 | cut -d '.' -f 1,2,3)

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
