## 使用prometheus监控kafka
### 部署kafka
使用helm进行部署

```bash
# 将rabbitmq的chart获取到本地
git clone https://github.com/kubesys/kubeOS.git

cd middleware-helm/kafka

# 若已设置好则不更改
vi values.yaml
   设置metrics:
        enabled: true

   设置persistence:
        enabled: false

   设置service:
        type: NodePort


# 部署kafka
cd ..
helm install ./kafka

# 检查状态
kubectl get po

# 在prometheus中的kubernetes-metrics-endpoint的job中可以直接获取到rabbitmq到数据

# 删除
helm list
helm delete [chartName]   
```
kafka的监控信息在prometheus中的kubernetes-pod的job中体现