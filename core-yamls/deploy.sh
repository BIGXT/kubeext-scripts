############################################
##
## Copyright (2019, ) Institute of Software
##      Chinese Academy of Sciences
##       {xuyuanjia2017,wuheng}@otcaix.iscas.ac.cn
##
############################################

version="v1.18.0"

function setupCluster()
{
  swapoff -a
  res=$(cat /etc/sysctl.conf | grep swappiness)
  sysctl net.bridge.bridge-nf-call-iptables=1
  systemctl stop firewalld
  systemctl disable firewalld
  systemctl enable docker.service
  if [[ -z $res ]]
  then
    echo "vm.swappiness = 0">> /etc/sysctl.conf 
  fi
  echo "1" > /proc/sys/net/bridge/bridge-nf-call-iptables
  echo "1" > /proc/sys/net/ipv4/ip_forward >/dev/null
  rm -rf $HOME/.kube
  rm -rf /etc/kubernetes
  systemctl enable kubelet
  systemctl start kubelet
  
  echo "kubeadm init --kubernetes-version=$version --imageRepository=registry.cn-hangzhou.aliyuncs.com/google_containers --token-ttl=0"
  kubeadm init --kubernetes-version=$version --imageRepository=registry.cn-hangzhou.aliyuncs.com/google_containers --token-ttl=0 
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
  iptables -P FORWARD ACCEPT

  wget -P /usr/bin http://39.106.124.113/edgecloud/corecloud/helm
  helm repo update
  #curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
  helm repo add bitnami https://charts.bitnami.com/bitnami
  helm repo add stable https://kubernetes.oss-cn-hangzhou.aliyuncs.com/charts

  kubectl apply -f yamls/
}

setupCluster
