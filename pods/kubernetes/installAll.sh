rm -rf /etc/yum.repos.d
mkdir /etc/yum.repos.d
mv ./CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo
mv ./kubernetes.repo /etc/yum.repos.d/kubernetes.repo
yum makecache
yum -y install kubelet kubeadm kubectl
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce
systemctl start docker
yum install bridge-utils
yum -y install net-tools
brctl delbr  flannel.1
brctl delbr cni0
