#! /bin/bash

# REMEMBER: install imagemagick (mogrify), libav-tools (avconv) and ftp
# this should run every day before timelapse
#set -vx
start_date=`date --rfc-3339=seconds`
echo $start_date

source ${HOME}/localhost/common.sh

before=`ls -lt $V`

i=30

find $V -mtime +$i -name "*.mpg" -type f -delete

after=`ls -lt $V`

num_before=`echo -n "$before" | wc -l`
num_after=`echo -n "$after" | wc -l`

end_date=`date --rfc-3339=seconds`

${HOME}/localhost/sendmail.sh "[delete] cleaned up!" "Start date: $start_date\n\nBefore($num_before):\n$before\n\nAfter($num_after):\n$after\n\nEnd date: $end_date"

echo -n "Done: "
echo $end_date
