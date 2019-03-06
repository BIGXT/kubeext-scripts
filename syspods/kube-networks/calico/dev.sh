############################################
##
## Copyright (2019, ) Institute of Software
##      Chinese Academy of Sciences
##       wuheng@otcaix.iscas.ac.cn
##
############################################

function setupCalico()
{
  while true
  do
    stat=`kubectl get po --all-namespaces | grep kube-apiserver | awk '{print $4}'`
    if [ "$stat" = "Running" ]
    then
      break
    fi
    sleep 5
  done
  
  kubectl create -f yamls/etcd.yaml
  kubectl create -f yamls/calico.yaml
}

setupCalico
