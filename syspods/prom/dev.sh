############################################
##
## Copyright (2019, ) Institute of Software
##      Chinese Academy of Sciences
##       wuheng@otcaix.iscas.ac.cn
##
############################################

for name in `cat yamls/* | grep "image\:"| grep -v “^$” | awk -F":" '{if($3!="")print$2":"$3}'`
do
  docker pull $name
done

kubectl apply -f yamls/
kubectl --namespace monitoring port-forward svc/prometheus-k8s 9090
kubectl --namespace monitoring port-forward svc/grafana 3000
kubectl --namespace monitoring port-forward svc/alertmanager-main 9093
