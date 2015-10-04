#! /bin/bash

# REMEMBER: install imagemagick (mogrify), libav-tools (avconv) and ftp
# this should run every day before timelapse
#set -vx
start_date=`date --rfc-3339=seconds`
echo $start_date

source ${HOME}/localhost/common.sh

before=`ls -l $V`

i=30

find $V -mtime +$i -name "*.avi" -type f -delete

after=`ls -l $V`

end_date=`date --rfc-3339=seconds`

${HOME}/localhost/sendmail.sh "[delete] cleaned up!" "Start date: $start_date\n\nBefore:\n$before\n\nAfter:\n$after\n\nEnd date: $end_date"

echo -n "Done: "
echo $end_date
