############################################
##
## Copyright (2019, ) Institute of Software
##      Chinese Academy of Sciences
##       wuheng@otcaix.iscas.ac.cn
##
############################################

function setupFlannel()
{
  kubectl create -f yamls/kube-flannel.yml
}

setupFlannel
