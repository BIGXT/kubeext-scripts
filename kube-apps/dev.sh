kubectl create namespace kube-paas
helm install kubeapps --namespace kube-paas bitnami/kubeapps --set useHelm3=true

kubectl create -n default serviceaccount example
kubectl create -n default rolebinding example-view \
  --clusterrole=kubeapps-applications-read \
  --serviceaccount default:example
kubectl create -n default rolebinding example-edit \
  --clusterrole=edit \
  --serviceaccount default:example

kubectl create clusterrolebinding example-kubeapps-service-catalog-browse --clusterrole=kubeapps-service-catalog-browse --serviceaccount default:example
kubectl create -n default rolebinding example-kubeapps-service-catalog-read --clusterrole=kubeapps-service-catalog-read --serviceaccount default:example


kubectl create -n default rolebinding example-kubeapps-service-catalog-write --clusterrole=kubeapps-service-catalog-write --serviceaccount default:example
kubectl create clusterrolebinding example-kubeapps-service-catalog-admin --clusterrole=kubeapps-service-catalog-admin --serviceaccount default:example

kubectl create -n kube-paas rolebinding example-kubeapps-repositories-read \
  --clusterrole=kubeapps:kube-paas:apprepositories-read \
  --serviceaccount default:example
kubectl create -n kube-paas rolebinding example-kubeapps-repositories-write \
  --clusterrole=kubeapps:kube-paas:apprepositories-write \
  --serviceaccount default:example

kubectl create -n kube-paas rolebinding example-kubeapps-applications-write --clusterrole=kubeapps-applications-read --serviceaccount default:example
kubectl create -n kube-paas rolebinding example-kubeapps-applications-write --clusterrole=kubeapps-applications-write --serviceaccount default:example
kubectl create clusterrolebinding example-kubeapps-applications-write --clusterrole=kubeapps-applications-read --serviceaccount default:example
kubectl create clusterrolebinding example-kubeapps-applications-write --clusterrole=kubeapps-applications-write --serviceaccount default:example

