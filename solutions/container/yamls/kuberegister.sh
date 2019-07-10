wget https://raw.githubusercontent.com/ContainerSolutions/trow/master/install/trow.yaml

mv trow.yaml kuberegister.yaml

sed -i "s/namespace: kube-public/namespace: kube-system/g" kuberegister.yaml
