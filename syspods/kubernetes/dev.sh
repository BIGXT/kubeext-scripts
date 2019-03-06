############################################
##
## Copyright (2019, ) Institute of Software
##      Chinese Academy of Sciences
##       wuheng@otcaix.iscas.ac.cn
##
############################################

version="v1.13.3"
podcidr="192.168.0.0/16"

function setupCluster()
{
  swapoff -a
  echo "1" > /proc/sys/net/bridge/bridge-nf-call-iptables
  rm -rf $HOME/.kube
  systemctl enable kubelet
  systemctl start kubelet
  
  echo "kubeadm init --kubernetes-version=$version --pod-network-cidr=$podcidr --token-ttl=0"
  kubeadm init --kubernetes-version=$version --pod-network-cidr=$podcidr --token-ttl=0 
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

  kubectl taint nodes --all node-role.kubernetes.io/master-
  iptables -P FORWARD ACCEPT
}

bash pull.sh
setupCluster
