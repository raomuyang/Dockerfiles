# Ubuntu with Nginx
# Author raomengnan
FROM raomengnan/ubuntu-base
MAINTAINER raomengnan

# 安装升级gcc
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get update

# 添加相关的src
RUN apt-get -y install build-essential
RUN apt-get -y install supervisor
RUN mkdir -p /usr/local/temp

COPY supervisor.conf /etc/supervisor/conf.d/supervisord.conf

# ADD 添加本地的src会自动解压，但添加网络的src不能自动解压
# ADD http://nginx.org/download/nginx-1.8.0.tar.gz  /usr/local/temp
# ADD http://zlib.net/zlib-1.2.8.tar.gz /usr/local/temp
# ADD http://www.openssl.org/source/openssl-1.0.1q.tar.gz /usr/local/temp
# ADD http://downloads.sourceforge.net/project/pcre/pcre/8.37/pcre-8.37.tar.gz /usr/local/temp

RUN wget http://nginx.org/download/nginx-1.8.0.tar.gz && tar -zxvf nginx-1.8.0.tar.gz -C /usr/local/temp
RUN wget http://zlib.net/zlib-1.2.8.tar.gz && tar -zxvf zlib-1.2.8.tar.gz -C /usr/local/temp
RUN wget http://www.openssl.org/source/openssl-1.0.1q.tar.gz && tar -zxvf openssl-1.0.1q.tar.gz -C /usr/local/temp
RUN wget http://downloads.sourceforge.net/project/pcre/pcre/8.37/pcre-8.37.tar.gz && tar -zxvf pcre-8.37.tar.gz -C /usr/local/temp

RUN rm *.tar.gz

# 安装
RUN ls /usr/local/temp/nginx-1.8.0
RUN cd /usr/local/temp/nginx-1.8.0 \
      && ./configure --sbin-path=/usr/local/nginx-1.8.0/nginx --conf-path=/usr/local/nginx-1.8.0/nginx.conf --pid-path=/usr/local/nginx-1.8.0/nginx.pid --with-http_ssl_module --with-pcre=/usr/local/temp/pcre-8.37 --with-zlib=/usr/local/temp/zlib-1.2.8 --with-openssl=/usr/local/temp/openssl-1.0.1q \
      && make \
      && make install

# 设置nginx是非daemon启动
RUN echo "\ndaemon off;" >> /usr/local/nginx-1.8.0/nginx.conf
RUN echo 'master_process off;' >> /usr/local/nginx-1.8.0/nginx.conf
RUN echo 'error_log  logs/error.log;' >> /usr/local/nginx-1.8.0/nginx.conf

RUN rm -rf /usr/local/temp/*
ENV NGINX_HOME /usr/local/nginx-1.8.0
RUN update-alternatives --install /usr/bin/nginx nginx /usr/local/nginx-1.8.0/nginx 300

EXPOSE 80
EXPOSE 22
# CMD /bin/zsh
CMD ["/usr/bin/supervisord"]
