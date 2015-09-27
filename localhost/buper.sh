#!/bin/sh

./rpi_buper.sh rpi/

REPOSITORY=/media/paul/backup/backup.attic

attic create --stats                            \
    $REPOSITORY::hostname-`date +%Y-%m-%d`      \
    /home/paul                                  \
    --exclude /home/paul/.gvfs                  \
    --exclude /home/paul/.thumbnails            \
    --exclude /home/paul/.local/share/Trash     \
    --exclude /home/paul/.cache                 \
    --exclude /home/paul/Downloads              \
    --exclude /home/paul/HDD-VM                 \
    --exclude /home/paul/VirtualBox\ VMs        \
    --exclude '*.pyc'                           \
    --exclude '*.o'

# Use the `prune` subcommand to maintain 7 daily, 4 weekly
# and 6 monthly archives.
attic prune -v $REPOSITORY --keep-daily=7 --keep-weekly=4 --keep-monthly=6
