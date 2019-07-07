wget https://raw.githubusercontent.com/giantswarm/prometheus/master/manifests-all.yaml

rm -rf kubemonitor.yaml
mv manifests-all.yaml kubemonitor.yaml

sed -i "s/namespace: monitoring/namespace: kube-system/g" kubemonitor.yaml
sed -i "s/imagePullPolicy: Always/imagePullPolicy: IfNotPresent/g" kubemonitor.yaml
sed -i "s/v1.7.0/v2.10.0/g" kubemonitor.yaml
sed -i "s/4.2.0/6.2.5/g" kubemonitor.yaml
sed -i "s/v0.7.1/v0.17.0/g" kubemonitor.yaml
sed -i "s/v0.14.0/v0.18.1/g" kubemonitor.yaml
sed -i "s/v0.9.3/v0.9.4/g" kubemonitor.yaml
sed -i "s/v0.5.0/v1.6.0/g" kubemonitor.yaml
