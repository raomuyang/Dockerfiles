# Hadoop in ubuntu
# Author raomengnan

FROM raomengnan/oracle-jdk-1.8.92-ubuntu
MAINTAINER raomengnan

# 考虑安全因素，真机环境下应该创建一个hadoop用户，在docker环境下就无须顾虑于此
RUN useradd -m hadoop -p hadoop -s /bin/bash && adduser hadoop sudo
ADD hadoop-2.7.3.tar.gz /usr/local/
COPY config /hadoop_config
RUN cp /hadoop_config/hadoop-env.sh /usr/local/hadoop-2.7.3/etc/hadoop/hadoop-env.sh
# RUN chown -R hadoop /usr/local/hadoop-2.7.3

RUN /etc/init.d/ssh start
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_dsa
RUN cd ~/.ssh && cat id_dsa.pub >> authorized_keys

ENV PATH $PATH:/usr/local/hadoop-2.7.3/bin:/usr/local/hadoop-2.7.3/sbin
ENV HADOOP_HOME /usr/local/hadoop-2.7.3
ENV HADOOP_COMMON_LIB_NATIVE_DIR $HADOOP_HOME/lib/native

EXPOSE 22
EXPOSE 50070
EXPOSE 8088

CMD /bin/zsh
