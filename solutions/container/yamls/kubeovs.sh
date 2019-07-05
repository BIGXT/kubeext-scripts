wget https://raw.githubusercontent.com/alauda/kube-ovn/master/yamls/ovn.yaml
wget https://raw.githubusercontent.com/alauda/kube-ovn/master/yamls/kube-ovn.yaml


rm -rf kubeovs.yaml
cat ovn.yaml >> kubeovs.yaml
echo "---" >> kubeovs.yaml
cat kube-ovn.yaml >> kubeovs.yaml
rm -rf ovn.yaml
rm -rf kube-ovn.yaml


version=":v2.11"
prefix="registry.cn-hangzhou.aliyuncs.com/cloudplus-lab/"

for img in `cat kubeovs.yaml | grep "image:"  | awk -F"\"" '{print$2}'`
do
  echo "docker pull "$img 
  docker pull img
  name=$(echo $img | awk -F":" '{print$1}' | awk -F"/" '{print$NF}')
  echo "docker tag $img $prefix$name$version"
  docker tag $img $prefix$name$version
done

sed -i "s/namespace: kube-ovn/namespace: kube-system/g" kubeovs.yaml
sed -i "s/imagePullPolicy: Always/imagePullPolicy: IfNotPresent/g" kubeovs.yaml
sed -i "s/replicas: 2/replicas: 1/g" kubeovs.yaml
sed -i "s/index.alauda.cn\/alaudak8s\/kube-ovn-db:v0.6.0-pre/registry.cn-hangzhou.aliyuncs.com\/cloudplus-lab\/kube-ovn-db:v2.11/g" kubeovs.yaml
sed -i "s/index.alauda.cn\/alaudak8s\/kube-ovn-node:v0.6.0-pre/registry.cn-hangzhou.aliyuncs.com\/cloudplus-lab\/kube-ovn-node:v2.11/g" kubeovs.yaml
sed -i "s/index.alauda.cn\/alaudak8s\/kube-ovn-controller:v0.6.0-pre/registry.cn-hangzhou.aliyuncs.com\/cloudplus-lab\/kube-ovn-controller:v2.11/g" kubeovs.yaml
sed -i "s/index.alauda.cn\/alaudak8s\/kube-ovn-cni:v0.6.0-pre/registry.cn-hangzhou.aliyuncs.com\/cloudplus-lab\/kube-ovn-cni:v2.11/g" kubeovs.yaml
