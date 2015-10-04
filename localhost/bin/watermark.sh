#! /bin/bash

# REMEMBER: install imagemagick (mogrify), libav-tools (avconv) and ftp
# this should run every 10-20 mins
#set -vx

echo `date --rfc-3339=seconds`

source ${HOME}/localhost/common.sh

if [ ! -d "$P" ]; then
    mkdir "$P"
fi

if [ ! -d "$M" ]; then
    mkdir "$M"
fi

if [ ! -d "$V" ]; then
    mkdir "$V"
fi

echo "Watermarking pictures..."

find $P -name "*.jpg" |
while read pic; do
    firstPart=${pic%_*}
    datetime=${firstPart##*_}

    year=${datetime:0:4}
    month=${datetime:4:2}
    day=${datetime:6:2}
    hour=${datetime:8:2}
    min=${datetime:10:2}
    sec=${datetime:12:2}

    dt="${year}-${month}-${day} ${hour}:${min}:${sec}"

    mogrify -font courier -pointsize 20 -draw "gravity south fill black
        text 0,12 '$dt' fill white text 1,11
        '$dt'" "$pic" &> /dev/null

    mv "$pic" "$M/${year}-${month}-${day}_${hour}_${min}_${sec}".jpg
done

echo -n "Done: "
echo `date --rfc-3339=seconds`
