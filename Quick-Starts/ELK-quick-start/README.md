### 通过Docker快速搭建elk服务

参考elastic官方文档：
* [Elastic run in docker](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html)
* [Kibana run in docker](https://www.elastic.co/guide/en/kibana/current/docker.html)
* [Logstash run in docker](https://www.elastic.co/guide/en/logstash/current/docker.html)

1: elk使用 docker-compose 部署，需安装docker及[docker-compose](https://docs.docker.com/compose/install/):
* `bash prepare.sh` 可自动安装docker-compose
* `bash prepare.sh dc` 自动准备docker CE 并安装docker-compose

2: 依次进入 Elastic Kibana Logstash 目录，执行 `docker-compose up -d`，根据配置自动拉取镜像并启动相应的容器
Note:
* 需修改Kibana的配置文件kibana.yml中`elasticsearch.url`为Elasticsearch容器部署机器的真实IP地址，不能写localhost/127.0.0.1
* 需修改Logstash中docker-compose.yml配置中的`extra_hosts`为Elasticsearch容器部署的真实IP地址

3: 测试相应的容器是否成功启动：
* `docker ps` 可以看到四个运行中的容器(elasticsearch, elasticsearch2, kibana, logstash)
* `curl http://127.0.0.1:9200/_cat/health` 查看elasticsearch的健康状态
* 访问 `http://localhost:5601`查看kibana是否能正常访问
* logstash 需根据配置复制log4j日志文件到相应的目录下，`docker logs logstash`可以看到日志创建记录（demo的配置中将 /home/bio-data/LogAnalysisRoot挂载到了logstash容器中，通过file插件收集日志）

