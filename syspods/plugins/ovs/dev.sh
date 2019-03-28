#############################################
##
## Copyright (2019, ) Institute of Software
##     Chinese Academy of Sciences
##      wuheng@otcaix.iscas.ac.cn
##
############################################

\cp bridge /opt/cni/bin/bridge
kubectl create -f yamls/flannel.yaml 
kubectl create -f yamls/multus.yaml 
kubectl create -f yamls/ovs-cni.yaml 
kubectl create -f yamls/ovs-conf.yaml
