#!/usr/bin/env bash

# docker-ce
if [ $1 = dc ];then
	curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
	sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
	sudo add-apt-repository    "deb [arch=amd64] https://mirrors.aliyun.com/docker-ce/linux/ubuntu \
		$(lsb_release -cs) \
		stable"
	sudo apt update
	sudo apt-get install -y docker-ce
	sudo usermod -aG docker $USER
fi

# docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
curl -L https://raw.githubusercontent.com/docker/compose/1.1.0/contrib/completion/bash/docker-compose > tmp
sudo cp tmp /etc/bash_completion.d/docker-compose

# Elasticsearch: config "max virtual memory", at least 262144
# sudo sysctl -w vm.max_map_count=262144
