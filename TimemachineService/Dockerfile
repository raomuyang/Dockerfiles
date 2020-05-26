# Author raomengnan

FROM ubuntu:16.04

RUN apt-get update

RUN apt-get install wget supervisor python-pip python-dev build-essential -y
RUN apt-get install libevent-dev libssl-dev libgcrypt11-dev libkrb5-dev libpam0g-dev libwrap0-dev libdb-dev libtdb-dev libmysqlclient-dev avahi-daemon libavahi-client-dev libacl1-dev libldap2-dev libcrack2-dev systemtap-sdt-dev libdbus-1-dev libdbus-glib-1-dev libglib2.0-dev libio-socket-inet6-perl tracker libtracker-sparql-1.0-dev libtracker-miner-1.0-dev -y

RUN wget https://nchc.dl.sourceforge.net/project/netatalk/netatalk/3.1.11/netatalk-3.1.11.tar.gz
RUN tar zxf netatalk-3.1.11.tar.gz
RUN cd netatalk-3.1.11 && ./configure \
        --with-init-style=debian-systemd \
        --without-libevent \
        --without-tdb \
        --with-cracklib \
        --enable-krbV-uam \
        --with-pam-confdir=/etc/pam.d \
        --with-dbus-daemon=/usr/bin/dbus-daemon \
        --with-dbus-sysconf-dir=/etc/dbus-1/system.d \
        --with-tracker-pkgconfig-version=1.0 \
    && make && make install 
RUN netatalk -V && afpd -V

RUN mkdir -p /usr/local/etc/ 
COPY afp.conf /usr/local/etc/afp.conf
COPY avahi-daemon.conf /etc/avahi/avahi-daemon.conf
RUN mkdir -p /media/timemachine
RUN apt-get install vim -y

COPY init-user.sh /usr/local/bin/init-user
RUN chmod a+x /usr/local/bin/init-user

CMD netatalk && init-user && avahi-daemon --no-rlimits 

ENV AFP_USER changeme
ENV AFP_PASSWD changeme
