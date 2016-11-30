# ZooKeeper
# Author raomengnan

FROM raomengnan/oracle-jdk-1.8.92-ubuntu
MAINTAINER raomengnan

ADD zookeeper-3.4.6.tar.gz /usr/local/
ADD zoo.cfg /usr/local/zookeeper-3.4.6/
RUN cd /usr/local/zookeeper-3.4.6
RUN mkdir /usr/local/zookeeper-3.4.6/data && mkdir /usr/local/zookeeper-3.4.6/logs
RUN echo 1 >> /usr/local/zookeeper-3.4.6/data/myid

ENV ZOOKEEPER_HOME /usr/local/zookeeper-3.4.6
ENV PATH $PATH:/usr/local/zookeeper-3.4.6/bin

EXPOSE 2181
EXPOSE 2888
EXPOSE 3888

CMD /bin/zsh
