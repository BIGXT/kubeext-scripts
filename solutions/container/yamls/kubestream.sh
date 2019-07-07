wget https://github.com/strimzi/strimzi-kafka-operator/releases/download/0.12.1/strimzi-cluster-operator-0.12.1.yaml

rm -rf kubestream.yaml
mv strimzi-cluster-operator-0.12.1.yaml kubestream.yaml

oversion=":0.12.1"
nversion=":v1.14.3"
prefix="registry.cn-hangzhou.aliyuncs.com/cloudplus-lab/"
nickname="kube-streaming"

for img in `cat kubestream.yaml | grep "image:" | grep "\/"  | awk -F":" '{print$2}'`
do
  echo "docker pull "$img$oversion 
  docker pull $img
  name=$(echo $img | awk -F":" '{print$1}' | awk -F"/" '{print$NF}')
  echo "docker tag $img $prefix$nickname$nversion"
  docker tag $img $prefix$nickname$nversion
done

sed -i "s/namespace: myproject/namespace: kube-system/g" kubestream.yaml
sed -i "s/imagePullPolicy: Always/imagePullPolicy: IfNotPresent/g" kubestream.yaml
sed -i "s/strimzi\/operator$oversion/registry.cn-hangzhou.aliyuncs.com\/cloudplus-lab\/$nickname$nversion/g" kubestream.yaml
