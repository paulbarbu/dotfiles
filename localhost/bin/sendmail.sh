#! /bin/bash

if [ -z "$1" ]
then
	echo "Subject cannot be empty!"
	exit 1
fi

if [ -z "$2" ]
then
	echo "Body cannot be empty!"
	exit 1
fi

to="$3"
to=${to:-"barbu.paul.gheorghe@gmail.com"}

echo -e "Subject: $1\r\n\r\n$2" | msmtp --from=default -t $to
