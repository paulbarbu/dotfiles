#!/bin/sh

# In order to backup from the RPi to the local PC use:
# rsync --rsync-path 'sudo rsync' -aAXv rpi:/home --exclude={"/var/local","/var/mail","/var/lost+found","/var/lock","/var/run","/usr/games","/usr/sbin","/var/tmp","/var/lib/initramfs-tools/","/var/lib/dpkg","/var/lib/apt","/var/libs","/var/backups","/var/cache","/usr/src","/usr/local","/usr/share","/sbin","/usr/lib","/usr/include","/usr/bin","/var/log","/var.old","/lib","/home/pi/.local","/home/pi/.vscode-server","/home/pi/.cache","/boot","/bin","/dev","/proc","/sys","/tmp","/run","/mnt","/media","/lost+found"} rpi4/
# rsync --rsync-path 'sudo rsync' -aAXv rpi:/etc --exclude={"/var/local","/var/mail","/var/lost+found","/var/lock","/var/run","/usr/games","/usr/sbin","/var/tmp","/var/lib/initramfs-tools/","/var/lib/dpkg","/var/lib/apt","/var/libs","/var/backups","/var/cache","/usr/src","/usr/local","/usr/share","/sbin","/usr/lib","/usr/include","/usr/bin","/var/log","/var.old","/lib","/home/pi/.local","/home/pi/.cache","/boot","/bin","/dev","/proc","/sys","/tmp","/run","/mnt","/media","/lost+found"} rpi4/

##
## ATTENTION, do not forget to call this with the remote backup server from time to time
## Also please check the repos from time to time: `borg check`
##

today=`date +%Y-%m-%d`
repodate=`date +%Y-%m-%d`

#echo 'Backing up MySQL'
#mysqldump -u root -p --all-databases > dump-${today}.sql

echo 'Backing up crontab'
crontab -l -u paul > crontab-${today}

#./rpi_buper.sh rpi/

REPOSITORY=/media/paul/backup/backup.borg

if [ "$1" = "remote" ]
then
    REPOSITORY=backup:/home/pi/backup/backup.borg
    echo 'Using remote repository.'

    if [ "$2" = "weekly" ]
    then
        repodate=`date +%W`
        echo 'Automated weekly backup.'
    fi
fi

echo 'Starting borg...'

borg create --stats                             \
    $REPOSITORY::hostname-$repodate             \
    /home/paul                                  \
    --exclude /home/paul/.gvfs                  \
    --exclude /home/paul/.thumbnails            \
    --exclude /home/paul/.local/share/Trash     \
    --exclude /home/paul/.local/bin             \
    --exclude /home/paul/.local/lib             \
    --exclude /home/paul/.local/etc             \
    --exclude /home/paul/.local/audman          \
    --exclude /home/paul/.cache                 \
    --exclude /home/paul/.opam                  \
    --exclude /home/paul/.ocp                   \
    --exclude /home/paul/.stack                 \
    --exclude /home/paul/.cabal                 \
    --exclude /home/paul/.netbeans              \
    --exclude /home/paul/.eclipse               \
    --exclude /home/paul/.vscode                \
    --exclude /home/paul/.gradle                \
    --exclude /home/paul/.rustup                \
    --exclude /home/paul/.cargo                 \
    --exclude /home/paul/.m2                    \
    --exclude /home/paul/.vmware                \
    --exclude /home/paul/.audacity-data         \
    --exclude /home/paul/localhost/.metadata    \
    --exclude /home/paul/Downloads              \
    --exclude /home/paul/HDD-VM                 \
    --exclude /home/paul/VirtualBox\ VMs        \
    --exclude '*.pyc'                           \
    --exclude '*.o' 2>&1 | tee /tmp/borg-create-${today}.log

echo 'Starting the prune command...'
# Use the `prune` subcommand to maintain 7 daily, 4 weekly
# and 6 monthly archives and all the yearly ones.
borg prune -v $REPOSITORY --stats --keep-daily=7 --keep-weekly=4 --keep-monthly=6 --keep-yearly=-1 2>&1 | tee /tmp/borg-prune-${today}.log

echo 'Done! Sending email...'
create_output=`cat /tmp/borg-create-${today}.log`
prune_output=`cat /tmp/borg-prune-${today}.log`
./bin/sendmail.sh "[backup] done!" "The backup has ended!\n\nborg create:\n$create_output\n\nborg prune:\n$prune_output"
