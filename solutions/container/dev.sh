############################################
##
## Copyright (2019, ) Institute of Software
##      Chinese Academy of Sciences
##       wuheng@otcaix.iscas.ac.cn
##
############################################

version=$(kubeadm version | awk -F"GitVersion:\"" '{print$2}' | awk -F"\"" '{print$1}')
podcidr="192.192.0.0/16"

VALUE1=gcr.azk8s.cn
KEY1=gcr.io

VALUE2=gcr.azk8s.cn/google_containers
KEY2=k8s.gcr.io

function download()
{
  name=${line//$1/$2}
  echo docker pull $name
  docker pull $name
  docker tag $name $3
  docker rmi $name
}


function pullImages()
{
  while read line
  do
    img=$(echo $line | awk -F":" '{print$1}')
    ver=$(echo $line | awk -F":" '{print$2}')
    res=$(docker images | grep "$img" | grep "$ver" | grep -v grep)
    if [[ -z $res ]]
    then
      prefix=$(echo $line | awk -F"/" '{print$1}')
      if [[ "$prefix" == "$KEY1" ]]
      then
        download $KEY1 $VALUE1 $line
      elif [[ "$prefix" == "$KEY2" ]]
      then
        download $KEY2 $VALUE2 $line
      fi
    fi
  done < images.conf
}

function setupCluster()
{
  swapoff -a
  
  res=$(cat /etc/sysctl.conf | grep swappiness)
  if [[ -z $res ]]
  then
    echo "vm.swappiness = 0">> /etc/sysctl.conf 
  fi

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

function setupOvs()
{
  yum install -y openvswitch libibverbs -y
  systemctl start openvswitch
  systemctl enable openvswitch
  kubectl label node $host kube-ovn/role=master
  kubectl apply -f yamls/kubeovs.yaml
  kubectl delete namespace kube-ovn
}

function setupStateful()
{
  kubectl apply -f yamls/kubeappc.yaml
  kubectl delete namespace kruise-system
}

function setupStreaming()
{
  kubectl apply -f yamls/kubestream.yaml
}

function setupFlannel()
{
  kubectl apply -f yamls/flannel.yml
}

function setupMonitoring()
{
  kubectl apply -f yamls/kubemonitor.yaml
  kubectl apply -f yamls/kubemonitor.yaml
  kubectl delete ns monitoring
}

pullImages
setupCluster
#setupFlannel
#setupOvs
#setupStateful
#setupStreaming
#setupMonitoring
