#!/bin/sh

##
## ATTENTION, do not forget to call this with the remote backup server from time to time
## Also please check the repos from time to time: `attic check`
##

today=`date +%Y-%m-%d`

mysqldump -u root -p --all-databases > dump-${today}.sql
crontab -l -u paul > crontab-${today}

#./rpi_buper.sh rpi/

REPOSITORY=/media/paul/backup/backup.attic

if [ "$#" -eq 1 ]
then
    REPOSITORY=backup:/home/pi/backup/backup.attic
    echo 'Using remote repository.'
fi

echo 'Starting attic...'

attic create --stats                            \
    $REPOSITORY::hostname-$today                \
    /home/paul                                  \
    --exclude /home/paul/.gvfs                  \
    --exclude /home/paul/.thumbnails            \
    --exclude /home/paul/.local/share/Trash     \
    --exclude /home/paul/.cache                 \
    --exclude /home/paul/Downloads              \
    --exclude /home/paul/HDD-VM                 \
    --exclude /home/paul/VirtualBox\ VMs        \
    --exclude '*.pyc'                           \
    --exclude '*.o' 2>&1 | tee /tmp/attic-create-${today}.log

# Use the `prune` subcommand to maintain 7 daily, 4 weekly
# and 6 monthly archives and all the yearly ones.
attic prune -v $REPOSITORY --keep-daily=7 --keep-weekly=4 --keep-monthly=6 --keep-yearly=-1 2>&1 | tee /tmp/attic-prune-${today}.log

create_output=`cat /tmp/attic-create-${today}.log`
prune_output=`cat /tmp/attic-prune-${today}.log`
./bin/sendmail.sh "[backup] done!" "The backup has ended!\n\nattic create:\n$create_output\n\nattic prune:\n$prune_output"
