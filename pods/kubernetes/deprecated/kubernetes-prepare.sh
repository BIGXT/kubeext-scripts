swapoff -a
sed -ri 's/.*swap.*/#&/' /etc/fstab
systemctl enable kubelet.service
setenforce 0
cp -r selinux /etc/sysconfig
systemctl stop firewalld
systemctl disable firewalld
mod +x /etc/rc.d/rc.local
echo "echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables" >> /etc/rc.d/rc.local
echo "echo 1 > /proc/sys/net/bridge/bridge-nf-call-ip6tables" >> /etc/rc.d/rc.local
echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables
echo 1 > /proc/sys/net/bridge/bridge-nf-call-ip6tables

