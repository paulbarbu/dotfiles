#!/bin/bash

# TODO: iptables-save

if [ $# -lt 1 ]; then
    echo "No destination defined. Usage: $0 destination" >&2
    exit 1
elif [ $# -gt 1 ]; then
    echo "Too many arguments. Usage: $0 destination" >&2
    exit 1
elif [ ! -d "$1" ]; then
   echo "Invalid path: $1" >&2
   exit 1
elif [ ! -w "$1" ]; then
   echo "Directory not writable: $1" >&2
   exit 1
fi

START=$(date +%s)

sshOpts="ssh -p 4242 -i /home/paul/.ssh/rpi-rsync -l root"
opts="-aAXvPR --numeric-ids --delete-excluded --delete"

rsync $opts -e "$sshOpts" --exclude-from=rpi_buper_excludes.txt -r --files-from=rpi_buper_files.txt root@192.168.0.202:/ "$1"

FINISH=$(date +%s)
result="total time: $(( ($FINISH-$START) / 60 )) minutes, $(( ($FINISH-$START) % 60 )) seconds" 

./bin/sendmail.sh "[rpi-backup] done!" "The rpi-backup has ended!\n\n$result"

echo $result
