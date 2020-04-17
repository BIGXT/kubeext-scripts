kubectl taint nodes --all node-role.kubernetes.io/master-
sed -i 's/volcano-system/kube-bigdata/' volcano.yaml
