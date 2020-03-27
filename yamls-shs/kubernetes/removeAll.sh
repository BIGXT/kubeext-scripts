systemctl stop docker
yum remove docker \
            docker-client \
            docker-client-latest \
            docker-common \
            docker-latest \
            docker-latest-logrotate \
            docker-logrotate \
            docker-selinux \
            docker-engine-selinux \
            docker-engine \
            docker \
            docker-ce \
            docker-ee
# rm -rf /var/lib/docker
yum -y remove kubelet kubeadm kubectl
ifconfig cni0 down
ifconfig flannel.1 down
ifconfig del flannel.1
ifconfig del cni0
ip link del flannel.1
ip link del cni0
