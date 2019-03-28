############################################
##
## Copyright (2019, ) Institute of Software
##      Chinese Academy of Sciences
##       wuheng@otcaix.iscas.ac.cn
##
############################################

function setupHelm()
{
  helm init --history-max 200
  kubectl create serviceaccount --namespace kube-system tiller
  kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
  kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
  helm repo add monocular https://helm.github.io/monocular
  helm install stable/nginx-ingress --set controller.hostNetwork=true 
  helm install monocular/monocular
  helm install monocular/monocular
  kubectl get ingress
}

setupHelm
