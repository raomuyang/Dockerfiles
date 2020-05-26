#!/usr/bin/env sh

if ! [ -f /hb/config.json ];then
	echo "/hb/config.json not found, please mount folder or copy file to here!"
	exit 1
fi

copy /hb/config.json ~/.homebridge/config.json

echo "start avhahi ..."
avahi-daemon --no-rlimits &

echo "initialed"
