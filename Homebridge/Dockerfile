# Author raomengnan

# base in avahi
FROM raomengnan/timemachine-service

RUN apt-get update
RUN apt-get install -y curl
# nodejs
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

RUN npm install -g --unsafe-perm homebridge
RUN npm install -g homebridge-mi-aqara
RUN mkdir -p ~/.homebridge

COPY init.sh /usr/sbin/hb-init
RUN chmod a+x /usr/sbin/hb-init

CMD hb-init && homebridge -D
