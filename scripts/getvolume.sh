#!usr/bin/bash

file="/tmp/volume.txt"
compvol=$(osascript -e 'output volume of (get volume settings)')
muted=$(osascript -e 'output muted of (get volume settings)')
while IFS= read line
do
        # display $line or do somthing with $line
	echo "$line@$compvol@$muted"
done <"$file"

rm /tmp/volume.txt
echo $compvol@$muted >> /tmp/volume.txt
