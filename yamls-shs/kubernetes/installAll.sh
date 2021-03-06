yum install centos-release
rm -rf /etc/yum.repos.d
mkdir /etc/yum.repos.d
cp ../../yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo
cp ../../yum.repos.d/kubernetes.repo /etc/yum.repos.d/kubernetes.repo
yum makecache
yum -y install kubelet-1.17.4-0.x86_64 kubeadm-1.17.4-0.x86_64 kubectl-1.17.4-0.x86_64
yum -y install yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce
systemctl start docker
yum install bridge-utils
yum -y install net-tools
brctl delbr  flannel.1
brctl delbr cni0
