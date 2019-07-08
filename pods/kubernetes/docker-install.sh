yum -y remove docker
yum -y remove docker-ce
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
yum makecache fast
yum -y install docker-ce
service docker start
service docker status #查看docker服务是否正常
cp -f ./daemon.json /etc/docker

