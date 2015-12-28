#! /bin/bash

# REMEMBER: install imagemagick (mogrify), libav-tools (avconv) and ftp
# Alos add the pi user to the ftp group after you've set up the ftp daemon
# This should run once a day

source ${HOME}/localhost/common.sh

start_date=`date --rfc-3339=seconds`
echo $start_date

max_pic=`ls $M/*.jpg | sort -r | head -1`
min_pic=`ls $M/*.jpg | sort    | head -1`

max_pic_no_ext=${max_pic%.*}
min_pic_no_ext=${min_pic%.*}

max_dt=${max_pic_no_ext##*/}
min_dt=${min_pic_no_ext##*/}

# remove the seconds part
min_dt=${min_dt%_*}
max_dt=${max_dt%_*}

# rename the files to something that avconv can understand
ls $M/*.jpg | sort | awk -v dir=$M 'BEGIN{ a=0 }{ printf "mv %s " dir "/cam%09d.jpg\n", $0, a++ }' | bash

avi="${min_dt}__${max_dt}.mpg"
echo "Encoding to: $avi"
avconv -f image2 -i $M/cam%9d.jpg -c:v mpeg1video -q:v 4 "$V/$avi"

echo "Cleaning up ..."

rm $M/cam*.jpg

end_date=`date --rfc-3339=seconds`

${HOME}/localhost/sendmail.sh "[timelapse] encoded!" "Start date: $start_date\n\nFilename: $avi\n\nEnd date: $end_date"

echo -n "Done: "
echo $end_date
