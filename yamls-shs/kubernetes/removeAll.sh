systemctl stop docker
yum -y remove docker-ce
rm -rf /var/lib/docker
yum -y remove kubelet kubeadm kubectl
ifconfig cni0 down
ifconfig flannel.1 down
ifconfig del flannel.1
ifconfig del cni0
ip link del flannel.1
ip link del cni0
