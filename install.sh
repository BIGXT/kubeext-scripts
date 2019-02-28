############################################
##
## Copyright (2019, ) Institute of Software
##      Chinese Academy of Sciences
##       wuheng@otcaix.iscas.ac.cn
##
############################################

curl https://raw.githubusercontent.com/kubesys/kube-os/master/config > /etc/selinux/config
\cp *.repo /etc/yum.repos.d/
systemctl stop firewalld
systemctl disable firewalld
yum install docker-ce qemu-kvm qemu-img openvswitch -y
systemctl start docker 
systemctl enable docker
systemctl start openvswitch 
systemctl enable openvswitch
rpm --force -Uvh https://github.com/kubesys/kube-os/releases/download/1.0/kube-tools-v1.13.3-cloudplus.1903.x86_64.rpm

