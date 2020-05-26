#!/usr/bin/env sh
user=$AFP_USER
passwd=$AFP_PASSWD
if [ x$user != x ] && [ x$passwd != x ]; then
    echo "try to add new user: "$user
    useradd $user > /dev/null
    echo $user":"$passwd|chpasswd
fi

