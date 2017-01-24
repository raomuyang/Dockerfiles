#! /bin/bash
# Author:raomengnan
# Create_Date: 2016/10/28
base_dir=$(dirname $0)

if [ $# = 0 ]
then
  echo "[ERROR] 请输入要启动的形式  [ default | pseudo | distributed | stop ]"
  exit
fi

if [ x$1 = x"stop" ]
then
  mr-jobhistory-daemon.sh stop historyserver
  stop-yarn.sh
  stop-dfs.sh
  echo "[STOPPED]"
  exit
fi

if [ x$1 = x"default" ] || [ x$1 = x"pseudo" ] || [ x$1 = x"distributed" ]
then

  /etc/init.d/ssh start
  cp $base_dir/hadoop-env.sh $HADOOP_HOME/etc/hadoop/
  echo "[INFO] "$1"形式启动Hadoop"
  cp $base_dir/$1/* $HADOOP_HOME/etc/hadoop/

  # DEFAULT
  if [ x$1 = x"default" ]
  then
    echo "[FINISH]"
    exit
  fi

  # PSEUDO
  if [ x$1 = x"pseudo" ]
  then

    # 关闭当前已经打开的服务
    mr-jobhistory-daemon.sh stop historyserver
    stop-yarn.sh
    stop-dfs.sh

    echo "[INFO] 伪分布式环境: http://localhost:50070"
    if [ x$2 = x"f" ]
    then
      echo "[INFO] Format: Second time needn't format namenode"
      hadoop namenode -format
    fi


    start-dfs.sh
    # hdfs dfs -mkdir -p /user/hadoop
    # cd /user/hadoop
    # hdfs dfs -mkdir input
    # hdfs dfs -put ./etc/hadoop/*.xml input

    echo "[INFO]   Start yarn"
    #启动 yarn
    start-yarn.sh
    # 开启历史服务器，才能在Web中查看任务运行情况
    mr-jobhistory-daemon.sh start historyserver
    echo "[MESSAGE] Please check NameNode SecondaryNameNode DataNode Yarn[NodeManager ResourceManager]"
    echo "[MESSAGE] Stop Hadoop: stop-dfs.sh"
    echo "[MESSAGE] Stop YARN: stop-yarn.sh && mr-jobhistory-daemon.sh stop historyserver"
    echo "[MESSAGE] 不启用 YARN 时，是 “mapred.LocalJobRunner” 在运行任务，"\
         "          启用 YARN 之后，是 “mapred.YARNRunner” 在运行任务。启动 YARN 后可以通过" \
         "          Web 界面查看任务的运行情况：http://localhost:8088/cluster"
    echo "[FINISH]"
    exit
  fi

  if [ x$1 = x"distributed" ]
  then
    echo "[INFO] 分布式环境"
    echo "[INFO] 请确定ssh、host及hadoop的配置正确后启动服务，DataNode 的主机名写入slaves文件。"\
         "       YOU SHOULD MAKE SURE CONFIGURED CORRECTLY BEFORE START SERVICE BEFORE"

    echo "[INFO] 复制配置文件到SLAVES"
    cat $base_dir/distributed/slaves | while read line; do
      echo "[MESSAGE] 复制到"$line
      scp $base_dir/hadoop-env.sh  $line:$HADOOP_HOME/etc/hadoop/
      scp $base_dir/distributed/*  $line:$HADOOP_HOME/etc/hadoop/
    done

    # 关闭当前已经打开的服务
    mr-jobhistory-daemon.sh stop historyserver
    stop-yarn.sh
    stop-dfs.sh

    cd $HADOOP_HOME
    echo "[INFO] remove old directories"
    rm -r ./tmp     # 删除 Hadoop 临时文件
    rm -r ./logs/*   # 删除日志文件

    if [ x$2 = x"f" ]
    then
      echo "[INFO] Fromat: Second time needn't format namenode"
      hadoop namenode -format
    fi

    echo "[INFO] Start service in Master"
    start-dfs.sh
    start-yarn.sh
    mr-jobhistory-daemon.sh start historyserver
    hadoop dfsadmin -report

    echo "[MESSAGE] Please check NameNode SecondaryNameNode DataNode Yarn[NodeManager ResourceManager]"
    echo "[MESSAGE] Stop Hadoop: stop-dfs.sh"
    echo "[MESSAGE] Stop YARN: stop-yarn.sh && mr-jobhistory-daemon.sh stop historyserver"

    echo "[FINISH]"
    exit
  fi

else
  echo "[ERROR] $1 请输入要启动的形式  [ default | pseudo | distributed | stop ]"
  exit
fi
  #statements
