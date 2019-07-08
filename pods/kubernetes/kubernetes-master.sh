kubeadm reset
rm -rf ~/.kube
rm -rf /var/lib/etcd
kubeadm init --kubernetes-version=v1.15.0 --pod-network-cidr=10.244.0.0/16 --token-ttl=0 
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/62e44c867a2846fefb68bd5f178daf4da3095ccb/Documentation/kube-flannel.yml
kubectl taint nodes --all node-role.kubernetes.io/master-
iptables -P FORWARD ACCEPT

