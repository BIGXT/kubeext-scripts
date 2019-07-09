
url="https://raw.githubusercontent.com/coreos/kube-prometheus/master/manifests/"

rm -rf kubemonitor.yaml

wget https://raw.githubusercontent.com/coreos/prometheus-operator/master/example/prometheus-operator-crd/alertmanager.crd.yaml
wget https://raw.githubusercontent.com/coreos/prometheus-operator/master/example/prometheus-operator-crd/prometheus.crd.yaml
wget https://raw.githubusercontent.com/coreos/prometheus-operator/master/example/prometheus-operator-crd/prometheusrule.crd.yaml
wget https://raw.githubusercontent.com/coreos/prometheus-operator/master/example/prometheus-operator-crd/servicemonitor.crd.yaml
wget https://raw.githubusercontent.com/coreos/prometheus-operator/master/example/prometheus-operator-crd/podmonitor.crd.yaml

cat alertmanager.crd.yaml >> kubemonitor.yaml
echo "---" >> kubemonitor.yaml
rm -rf alertmanager.crd.yaml

cat prometheus.crd.yaml >> kubemonitor.yaml
echo "---" >> kubemonitor.yaml
rm -rf prometheus.crd.yaml

cat prometheusrule.crd.yaml >> kubemonitor.yaml
echo "---" >> kubemonitor.yaml
rm -rf prometheusrule.crd.yaml

cat servicemonitor.crd.yaml >> kubemonitor.yaml
echo "---" >> kubemonitor.yaml
rm -rf servicemonitor.crd.yaml

cat podmonitor.crd.yaml >> kubemonitor.yaml
echo "---" >> kubemonitor.yaml
rm -rf podmonitor.crd.yaml

while read line
do
    echo "wget "$url$line
    wget $url$line
    cat $line >> kubemonitor.yaml
    echo "---" >> kubemonitor.yaml
    rm -rf $line
done < kubemonitor.list

sed -i "s/namespace: monitoring/namespace: kube-system/g" kubemonitor.yaml
