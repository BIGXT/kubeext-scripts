# curl -L https://github.com/kubernetes/kompose/releases/download/v1.18.0/kompose-linux-amd64 -o kompose

wget https://raw.githubusercontent.com/grafana/loki/master/production/docker-compose.yaml

sed -i "s/namespace: monitoring/namespace: kube-system/g" kubemonitor.yaml
