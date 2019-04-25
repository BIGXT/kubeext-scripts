############################################
##
## Copyright (2019, ) Institute of Software
##      Chinese Academy of Sciences
##       wuheng@otcaix.iscas.ac.cn
##
############################################

kubectl label namespace default istio-injection=enabled
kubectl apply -f bookinfo.yaml
