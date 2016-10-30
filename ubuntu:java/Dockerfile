# Ubuntu with JDK
# Author raomengnan
FROM raomengnan/ubuntu-base
MAINTAINER raomengnan

ADD jdk1.8.092.tar.gz /usr/local/
RUN ls /usr/local
# RUN mkdir /usr/local/jdk1.8.092
# RUN tar -zxvf /usr/local/jdk1.8.092.tar.gz -C /usr/local/
# RUN rm /usr/local/jdk1.8.092.tar.gz
RUN update-alternatives --install /usr/bin/java java /usr/local/jdk1.8.092/bin/java 300
RUN update-alternatives --install /usr/bin/javac javac /usr/local/jdk1.8.092/bin/javac 300
ENV JAVA_HOME /usr/local/jdk1.8.092
ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV PATH $PATH:/usr/local/jdk1.8.092/bin
CMD /bin/zsh
