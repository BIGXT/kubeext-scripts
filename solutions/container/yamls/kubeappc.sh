
wget https://raw.githubusercontent.com/kruiseio/kruise/master/config/crds/apps_v1alpha1_broadcastjob.yaml
wget https://raw.githubusercontent.com/kruiseio/kruise/master/config/crds/apps_v1alpha1_sidecarset.yaml
wget https://raw.githubusercontent.com/kruiseio/kruise/master/config/crds/apps_v1alpha1_statefulset.yaml
wget https://raw.githubusercontent.com/kruiseio/kruise/master/config/manager/all_in_one.yaml

rm -rf kubeappc.yaml
cat apps_v1alpha1_broadcastjob.yaml >> kubeappc.yaml
echo "---" >> kubeappc.yaml
cat apps_v1alpha1_sidecarset.yaml >> kubeappc.yaml
echo "---" >> kubeappc.yaml >> kubeappc.yaml
cat apps_v1alpha1_statefulset.yaml >> kubeappc.yaml
echo "---" >> kubeappc.yaml >> kubeappc.yaml
cat all_in_one.yaml >> kubeappc.yaml
rm -rf apps_v1alpha1_broadcastjob.yaml
rm -rf apps_v1alpha1_sidecarset.yaml
rm -rf apps_v1alpha1_statefulset.yaml
rm -rf all_in_one.yaml


version=":v1.14.3"
prefix="registry.cn-hangzhou.aliyuncs.com/cloudplus-lab/"

for img in `cat kubeappc.yaml | grep "image:" | awk -F"image:" '{print$2}'`
do
  echo "docker pull "$img 
  docker pull $img
  name=$(echo $img | awk -F":" '{print$1}' | awk -F"/" '{print$NF}')
  echo "docker tag $img $prefix$name$version"
  nname=${name/kruise/kube-appcontroller}
  echo $nname
  docker tag $img $prefix$nname$version
done

sed -i "s/namespace: kruise-system/namespace: kube-system/g" kubeappc.yaml
sed -i "s/imagePullPolicy: Always/imagePullPolicy: IfNotPresent/g" kubeappc.yaml
sed -i "s/openkruise\/kruise-manager:daily/registry.cn-hangzhou.aliyuncs.com\/cloudplus-lab\/kube-appcontroller$version/g" kubeappc.yaml
