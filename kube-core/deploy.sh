############################################
##
## Copyright (2019, ) Institute of Software
##      Chinese Academy of Sciences
##       {xuyuanjia2017,wuheng}@otcaix.iscas.ac.cn
##
############################################

version="v1.18.2"

function setupKube()
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
  
  echo "kubeadm init --kubernetes-version=$version --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers --token-ttl=0"
  kubeadm init --kubernetes-version=$version --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers --token-ttl=0 
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
  iptables -P FORWARD ACCEPT

  mkdir -p /var/lib/grafana/dashboards/
  \cp jsons/* /var/lib/grafana/dashboards/
  kubectl apply -f yamls/
}

function setupHelm()
{
#  kubectl taint nodes --all node-role.kubernetes.io/master-

  if [[ ! -f "/usr/bin/helm" ]]
  then
    wget -P /usr/bin/ http://39.106.124.113/serverless/kubecore/helm
    chmod 777 /usr/bin/helm
  fi

  chmod 777 /usr/bin/helm
  
  helm repo add bitnami https://charts.bitnami.com/bitnami
  helm repo add stable https://kubernetes.oss-cn-hangzhou.aliyuncs.com/charts
  helm repo add harbor https://helm.goharbor.io
  helm repo update
}

setupIstio()
{
  ready=$(kubectl get po -n kube-system | grep coredns | grep Running)
  while [[ -z $ready ]]
  do
    sleep 3
  done
   
  helm template istio --namespace kube-system \
    --values istio/values-istio-demo.yaml \
    --set global.controlPlaneSecurityEnabled=true \
    --set global.mtls.enabled=true | kubectl apply -f -
}

setupKube
setupHelm
#setupIstio
