helm install loki --namespace=kube-system ./loki-stack-0.36.0.tgz 

# add datasource
```
apiVersion: 1

datasources:
  - name: Loki
    type: loki
    access: proxy
    url: http://loki:3100
    jsonData:
      maxLines: 1000
```
